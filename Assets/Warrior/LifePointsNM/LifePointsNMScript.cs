using UnityEngine;
using UnityEngine.AI; //2

public class LifePointsNMScript : MonoBehaviour
{
    public int healAmount;
    public bool startPursuit = false;
    public float timeToStartPursuit;

    //private bool veri = true;
    private GameObject player;
    private AudioSource audioSource;
    private NavMeshAgent navMeshAgent;


    void Start()
    {
        
        player = GameObject.FindGameObjectWithTag("Player");
        audioSource = GetComponent<AudioSource>();
        navMeshAgent = GetComponent<NavMeshAgent>();
        GetComponent<StartPursuitLifePointsScript>().Start(timeToStartPursuit);
        navMeshAgent.isStopped = true;
    }


    void Update()
    {
        if(startPursuit)
        {
            navMeshAgent.SetDestination(player.transform.position);
            navMeshAgent.isStopped = false;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            other.gameObject.GetComponent<PlayerHealthScript>().HealPlayer(healAmount);
            Destroy(gameObject);
        }
    }
}
