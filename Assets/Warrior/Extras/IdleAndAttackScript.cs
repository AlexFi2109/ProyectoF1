﻿using UnityEngine;

public class IdleAndAttackScript : MonoBehaviour
{
    public bool attack;
    public float rotationSpeed;
    public float particleSpeed;
    public float heightOffset;
    public float timeToExplode = 5;
    public GameObject spawnPoint;
    public GameObject particlePrefab;
    public AudioClip[] attackClips;
    public AudioClip[] dieClip;

    private bool hasDied;
    private Vector3 targetPosition;
    private GameObject player;
    private Animator animator;
    private AudioSource audioSource;
    private GameObject shootedParticle;

    void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        audioSource = GetComponent<AudioSource>();
        animator = GetComponent<Animator>();
    }


    void Update()
    {
        int health = GetComponent<EnemyHealthScript>().enemyHealth;

        if (health <= 0 && !hasDied) // Estado de morir
        {
            Die();
            return;
        }

        if (health > 0 && !attack)  //Estado de Idle
        {
            Idle();
            return;
        }

        if (attack && health > 0) // Estado de atacar
        {
            Attack();
        }

    }

    private void Idle()
    {
        animator.SetBool("Idle", true);
        animator.SetBool("Attack", false);
    }
    private void Attack()
    {
        animator.SetBool("Idle", false);
        animator.SetBool("Attack", true);
        targetPosition = player.transform.position - transform.position; 
        Quaternion newRotation = Quaternion.LookRotation(targetPosition);
        transform.rotation = Quaternion.Lerp(transform.rotation, newRotation, rotationSpeed * Time.deltaTime);
    }

    private void Die()
    {
        animator.SetBool("Idle", false);
        animator.SetBool("Attack", false);
        animator.SetBool("Dead", true);
        int dieClipIndex = Random.Range(0, dieClip.Length);
        audioSource.PlayOneShot(dieClip[dieClipIndex]);
        GetComponent<ExplodeWhenDieScript>().Explode(timeToExplode);
        hasDied = true;
    }

    public void AttackStopped()
    {

    }

    public void AttackStarted()
    {

    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.CompareTag("Player"))
        {
            attack = true;
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            attack = false;
        }
    }

    public void Shoot()
    {
        int attackClipIndex = Random.Range(0, attackClips.Length - 1);
        audioSource.PlayOneShot(attackClips[attackClipIndex]);
        Vector3 playerPositionOnGround = new Vector3(player.transform.position.x, 0, player.transform.position.z);
        Vector3 enemyPositionOnGround = new Vector3(spawnPoint.transform.position.x, 0, spawnPoint.transform.position.z);
        Vector3 playerPositionOnVerical = new Vector3(0, player.transform.position.y, 0);
        Vector3 enemyPositionOnVertical = new Vector3(0, spawnPoint.transform.position.y, 0);

        float distanceToPlayerinX = Vector3.Distance(playerPositionOnGround, enemyPositionOnGround);
        float distanceToPlayerinY = Vector3.Distance(playerPositionOnVerical, enemyPositionOnVertical);

        if (player.transform.position.y < spawnPoint.transform.position.y)
        {
            distanceToPlayerinY = (-1 * distanceToPlayerinY) + heightOffset;
        }

        else
        {
            distanceToPlayerinY = distanceToPlayerinY + heightOffset;
        }

        float time = distanceToPlayerinX / particleSpeed;
        float a = (9.81f / 2f) * (time * time);
        float b = -distanceToPlayerinX;
        float c = (a + distanceToPlayerinY);

        float tanA1 = (-b + Mathf.Sqrt(b * b - 4 * a * c)) / (2 * a);
        float tanA2 = (-b - Mathf.Sqrt(b * b - 4 * a * c)) / (2 * a);

        float angleA1 = Mathf.Atan(tanA1);
        float angleA2 = Mathf.Atan(tanA2);

        float angleA = 0;
        angleA = Mathf.Min(Mathf.Abs(angleA1), Mathf.Abs(angleA2));

        if (angleA2 > 0)
        {
            angleA = angleA * -1;
        }

        shootedParticle = Instantiate(particlePrefab, spawnPoint.transform.position, Quaternion.identity);
        spawnPoint.transform.localRotation = Quaternion.Euler(new Vector3(angleA * Mathf.Rad2Deg, 0, 0));
        shootedParticle.GetComponent<Rigidbody>().velocity = spawnPoint.transform.forward * particleSpeed;
    }
}
