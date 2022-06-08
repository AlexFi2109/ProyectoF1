using UnityEngine;
using UnityEngine.AI;

public class PatrolRunAndAttackScript : MonoBehaviour
{
    public bool startPursuit; //2
    public bool attack;
    public bool isAttacking = false;
    public float distanceTolerance = 0.5f; //3
    public int damageToPlayer;
    public float minSpeed;
    public float maxSpeed;
    public float timeToExplode = 5;
    public Transform[] patrolPoints; //3
    public AudioClip[] stepClips;
    public AudioClip[] attackClips;
    public AudioClip[] dieClip;

    private bool hasDied;
    private int patrolIndex = 0; //3
    private GameObject player;
    private NavMeshAgent navMeshAgent;
    private Animator animator;
    private AudioSource audioSource;


    void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        navMeshAgent = GetComponent<NavMeshAgent>();
        audioSource = GetComponent<AudioSource>();
        animator = GetComponent<Animator>();
        navMeshAgent.speed = Random.Range(minSpeed, maxSpeed);
        navMeshAgent.SetDestination(patrolPoints[0].position);
        navMeshAgent.autoBraking = false;   //3
        navMeshAgent.stoppingDistance = 0;  //3
        animator.SetBool("Run", true);  //3
    }


    void Update()
    {
        int health = GetComponent<EnemyHealthScript>().enemyHealth;

        if (health <= 0 && !hasDied) // Estado de morir
        {
            Die();
            return;
        }

        if (!startPursuit)  //Estado de patrullake
        {
            if(navMeshAgent.remainingDistance <= distanceTolerance)
            {
                Patrol();   //3                
            }

            return;
        }

        if (attack && health > 0) // Estado de atacar
        {
            Attack();
            return;
        }

        if (!attack && !isAttacking && health > 0)  // Estado de correr
        {
            RunTowardsPlayer();
        }
    }
    private void Patrol()
    {
        patrolIndex++;
        navMeshAgent.SetDestination(patrolPoints[patrolIndex].position);
        
        if (patrolIndex == patrolPoints.Length -1)
        {
            patrolIndex = -1;
        }
    }

    private void Attack()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Attack", true);
        navMeshAgent.isStopped = true;
    }

    private void RunTowardsPlayer()
    {
        navMeshAgent.SetDestination(player.transform.position);
        animator.SetBool("Run", true);
        animator.SetBool("Attack", false);
        navMeshAgent.isStopped = false; //1
    }

    private void Die()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Attack", false);
        animator.SetBool("Dead", true);
        navMeshAgent.isStopped = true;
        int dieClipIndex = Random.Range(0, dieClip.Length);
        audioSource.PlayOneShot(dieClip[dieClipIndex]);
        GetComponent<ExplodeWhenDieScript>().Explode(timeToExplode);
        hasDied = true;
    }
    public void AttackStopped()
    {
        isAttacking = false;
    }

    public void AttackStarted()
    {
        isAttacking = true;
    }

    public void StepSound()
    {
        int stepClipIndex = Random.Range(0, stepClips.Length);
        audioSource.PlayOneShot(stepClips[stepClipIndex]);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            attack = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            attack = false;
        }
    }

    public void WeaponHit()
    {
        if (attack)
        {
            player.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayer);
            audioSource.PlayOneShot(attackClips[0]);

        }
        else
        {
            audioSource.PlayOneShot(attackClips[1]);
        }
    }
}
