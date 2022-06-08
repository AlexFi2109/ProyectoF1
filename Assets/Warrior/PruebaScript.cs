using UnityEngine;
using UnityEngine.AI;

public class PruebaScript : MonoBehaviour
{
    public bool startPursuit; //2
    public bool attack;
    public bool shouting = false;
    public bool shoutFinnished = false;
    public bool isAttacking = false;
    public int damageToPlayer, damageToPlayerAngry;
    public float minSpeed;
    public float maxSpeed;
    public float timeToExplode = 8;
    public GameObject brother;
    public AudioClip[] shoutClips;
    public AudioClip[] stepClips;
    public AudioClip[] attackClips;
    public AudioClip[] dieClip;
    

    private bool angry = false;
    private bool startedShout; //1
    private bool hasDied;
    private bool hasDisappear;
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
        navMeshAgent.speed = minSpeed;
        navMeshAgent.stoppingDistance = 2;
    }


    void Update()
    {
        int health = GetComponent<EnemyHealthScript>().enemyHealth;
        navMeshAgent.SetDestination(player.transform.position);
        int brotherHealth = brother.GetComponent<EnemyHealthScript>().enemyHealth;

        if (health <= 0 && brotherHealth <= 0 && !hasDisappear)
        {
            Disappear();
            return;
        }

        if (health <= 0 && !hasDied) // Estado de morir
        {
            Die();
            return;
        }

        if (!startPursuit)
        {
            Idle();
            return;
        }

        if (attack && health > 0) // Estado de atacar
        {
            Attack();
        }

        if (!startedShout && health > 0 && brotherHealth <= 0) // Estado de rugir
        {
            Angry();
            Shout();
        }

        if (!attack && !isAttacking && health > 0 && (!startedShout || shoutFinnished))  // Estado de correr
        {
            RunTowardsPlayer();
        }
    }

    private void Idle()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Attack", false);
        animator.SetBool("Shout", false);
        navMeshAgent.isStopped = true;
    }

    private void Attack()
    {
        navMeshAgent.isStopped = true;
        animator.SetBool("Run", false);
        animator.SetBool("Attack", true);
        animator.SetBool("Shout", false);
        
    }

    private void RunTowardsPlayer()
    {
        navMeshAgent.SetDestination(player.transform.position);
        animator.SetBool("Run", true);
        animator.SetBool("Attack", false);
        animator.SetBool("Shout", false);
        navMeshAgent.isStopped = false; //1
    }

    //private void RunTowardsPlayerAngry()
    //{
    //    navMeshAgent.SetDestination(player.transform.position);
    //    animator.SetBool("Run", true);
    //    animator.SetBool("Attack", false);
    //    navMeshAgent.isStopped = false;

    //}

    private void Shout()
    {
        startedShout = true;
        animator.SetBool("Run", false);
        animator.SetBool("Shout", true);
        animator.SetBool("Attack", false);
        navMeshAgent.isStopped = true; //1
        gameObject.GetComponent<CapsuleCollider>().enabled = false;
        
        int shoutClipIndex = Random.Range(0, shoutClips.Length);
        audioSource.PlayOneShot(shoutClips[shoutClipIndex]);
    }


    private void Angry()
    {
        navMeshAgent.speed = maxSpeed;
        angry = true;
        navMeshAgent.stoppingDistance = 4;
        
    }

    private void Die()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Attack", false);
        animator.SetBool("Shout", false);
        animator.SetBool("Dead", true);
        navMeshAgent.isStopped = true;
        int dieClipIndex = Random.Range(0, dieClip.Length);
        audioSource.PlayOneShot(dieClip[dieClipIndex]);
        hasDied = true;
    }

    private void Disappear()
    {
        GetComponent<FadeOutScript>().Explode(timeToExplode);
        hasDisappear = true;
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
            if(angry)
            {
                player.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayerAngry);
            }

            else
            {
                player.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayer);
            }
            audioSource.PlayOneShot(attackClips[0]);
        }
        else
        {
            audioSource.PlayOneShot(attackClips[1]);
        }
    }
    public void ShoutFinnished()
    {
        shoutFinnished = true;
        gameObject.GetComponent<CapsuleCollider>().enabled = true;
        RunTowardsPlayer();
    }
}
