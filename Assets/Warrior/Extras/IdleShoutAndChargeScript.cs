using UnityEngine;
using UnityEngine.AI;

public class IdleShoutAndChargeScript : MonoBehaviour
{

    public bool startPursuit = false; //1
    public bool shoutFinnished = false;
    public int damageToPlayer;
    public float minSpeed;
    public float maxSpeed;
    public float timeToExplode = 5f;
    public AudioClip[] shoutClips;
    public AudioClip[] stepClips;
    public AudioClip[] dieClip;

    private bool startedShout; //1
    private bool hasDied;
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

    }


    void Update()
    {
        int health = GetComponent<EnemyHealthScript>().enemyHealth;

        if (health <= 0 && !hasDied)
        {
            Die();
            return;
        }
        
        if(!startPursuit) // Estado de esperar (idle)
        {
            Idle();
            return;
        }

        if (startPursuit && !startedShout && health >= 0) // Estado de rugir
        {
            Shout();
        }

        if (health >= 0 && shoutFinnished) // Estado de correr
        {
            RunTowardsPlayer();
        }

        
    }

    private void Idle()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Shout", false);
        navMeshAgent.isStopped = true;
    }

    private void Shout()
    {
        startedShout = true;
        animator.SetBool("Run", false);
        animator.SetBool("Shout", true);

        int shoutClipIndex = Random.Range(0, shoutClips.Length);
        audioSource.PlayOneShot(shoutClips[shoutClipIndex]);
    }

    private void RunTowardsPlayer()
    {
        navMeshAgent.SetDestination(player.transform.position);
        animator.SetBool("Run", true);
        animator.SetBool("Dead", false);
        navMeshAgent.isStopped = false; //1
    }

    private void Die()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Dead", true);
        navMeshAgent.isStopped = true;
        int dieClipIndex = Random.Range(0, dieClip.Length);
        audioSource.PlayOneShot(dieClip[dieClipIndex]);
        GetComponent<ExplodeWhenDieScript>().Explode(timeToExplode);
        hasDied = true;

    }

    public void ShoutFinnished()
    {
        shoutFinnished = true;
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
            player.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayer);
            GetComponent<ExplodeWhenDieScript>().Explode(0);
        }

    }
}
