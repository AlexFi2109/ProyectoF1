using UnityEngine;
using UnityEngine.AI;

public class HakScript : MonoBehaviour
{
    public bool startPursuit = false;
    public bool standFinnished = false;
    public bool isMagicAttacking = false;
    public bool magicAttack;
    public bool attack1;
    public bool attack2;
    public bool isAttacking1 = false;
    public bool isAttacking2 = false;
    public float rotationSpeed;
    public float particleSpeed;
    public float heightOffset;
    public int damageToPlayer;
    public float minSpeed;
    public float maxSpeed;
    public float timeToExplode = 3f;
    public GameObject spawnPoint;
    public GameObject particlePrefab;
    public AudioClip[] stepClips;
    public AudioClip[] dieClip;
    public AudioClip[] attack1Clips;
    public AudioClip[] attack2Clips;
    public AudioClip[] magicattackClips;

    private bool startedStand;
    private bool hasDied;
    private Vector3 targetPosition;
    private GameObject player;
    private NavMeshAgent navMeshAgent;
    private Animator animator;
    private AudioSource audioSource;
    private GameObject shootedParticle;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        navMeshAgent = GetComponent<NavMeshAgent>();
        audioSource = GetComponent<AudioSource>();
        animator = GetComponent<Animator>();
        navMeshAgent.speed = Random.Range(minSpeed, maxSpeed);
    }

    private void Update()
    {
        int health = GetComponent<EnemyHealthScript>().enemyHealth;

        if (health <= 0 && !hasDied)
        {
            Die();
            return;
        }

        if (!startPursuit)
        {
            Idle();
            return;
        }

        if (startPursuit && !startedStand && health > 0)
        {
            Stand();
        }

        if (attack1 && !magicAttack && health > 0)
        {
            Attack1();
        }

        if (attack2 && !magicAttack && health > 0)
        {
            Attack2();
        }

        if (!attack1 && magicAttack && health > 0)
        {
            Magic();
        }

        if (!attack1 && health >= 0 && standFinnished)
        {
            RunTowardsPlayer();
        }
    }

    private void Magic()
    {
        navMeshAgent.isStopped = true;
        animator.SetBool("Stand", false);
        animator.SetBool("Run", false);
        animator.SetBool("Magic", true);
        animator.SetBool("Attack1", false);
        animator.SetBool("Attack2", false);
        targetPosition = player.transform.position - transform.position;
        Quaternion newRotation = Quaternion.LookRotation(targetPosition);
        transform.rotation = Quaternion.Lerp(transform.rotation, newRotation, rotationSpeed * Time.deltaTime);
    }

    private void Idle()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Stand", false);
        animator.SetBool("Magic", false);
        animator.SetBool("Attack1", false);
        animator.SetBool("Attack2", false);
        navMeshAgent.isStopped = true;
    }

    private void Stand()
    {
        startedStand = true;
        animator.SetBool("Run", false);
        animator.SetBool("Stand", true);
        animator.SetBool("Magic", false);
        animator.SetBool("Attack1", false);
        animator.SetBool("Attack2", false);
    }

    private void Attack1()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Attack1", true);
        animator.SetBool("Attack2", false);
        animator.SetBool("Stand", false);
        animator.SetBool("Magic", false);
        navMeshAgent.isStopped = true;
    }

    private void Attack2()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Attack1", false);
        animator.SetBool("Attack2", true);
        animator.SetBool("Stand", false);
        animator.SetBool("Magic", false);
        navMeshAgent.isStopped = true;
    }

    private void RunTowardsPlayer()
    {
        navMeshAgent.SetDestination(player.transform.position);
        animator.SetBool("Run", true);
        animator.SetBool("Defeat", false);
        animator.SetBool("Magic", false);
        animator.SetBool("Attack1", false);
        navMeshAgent.isStopped = false;
    }

    private void Die()
    {
        animator.SetBool("Run", false);
        animator.SetBool("Defeat", true);
        animator.SetBool("Magic", false);
        animator.SetBool("Attack1", false);
        animator.SetBool("Attack2", false);
        navMeshAgent.isStopped = true;
        int dieClipIndex = Random.Range(0, dieClip.Length);
        audioSource.PlayOneShot(dieClip[dieClipIndex]);
        GetComponent<DissapearWithMagicScript>().Dissapear(timeToExplode);
        hasDied = true;
    }

    public void StandFinnished()
    {
        standFinnished = true;
    }

    public void MagicAttackStopped()
    {
        isMagicAttacking = false;
    }

    public void MagicAttackStarted()
    {
        isMagicAttacking = true;
    }

    public void Attack1Stopped()
    {
        isAttacking1 = false;
    }

    public void Attack1Started()
    {
        isAttacking1 = true;
    }

    public void Attack2Stopped()
    {
        isAttacking2 = false;
    }

    public void Attack2Started()
    {
        isAttacking2 = true;
    }

    public void StepSound()
    {
        int stepClipIndex = Random.Range(0, stepClips.Length);
        audioSource.PlayOneShot(stepClips[stepClipIndex]);
    }


    public void Shoot()
    {
        int magicattackClipIndex = Random.Range(0, magicattackClips.Length - 1);
        audioSource.PlayOneShot(magicattackClips[magicattackClipIndex]);
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

    public void KickHit()
    {
        if (attack1)
        {
            player.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayer);
            audioSource.PlayOneShot(attack1Clips[0]);
        }
        else
        {
            audioSource.PlayOneShot(attack1Clips[1]);
        }
    }

    public void SwordHit()
    {
        if (attack1)
        {
            player.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayer);
            audioSource.PlayOneShot(attack2Clips[0]);
        }
        else
        {
            audioSource.PlayOneShot(attack2Clips[1]);
        }
    }
}
