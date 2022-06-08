using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LifePointsScript : MonoBehaviour
{
    public float heightOffset;
    public float particleSpeed;
    public float rotationSpeed;
    public int lifeToPlayer;
    //public GameObject particlePrefab;


    private bool boli = true;
    private Vector3 targetPosition;
    private GameObject player;
    private Animator animator;
    private AudioSource audioSource;
    private GameObject shootedParticle;


    void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        audioSource = GetComponent<AudioSource>();
    }


    void Update()
    {
        targetPosition = player.transform.position - transform.position;
        Quaternion newRotation = Quaternion.LookRotation(targetPosition);
        transform.rotation = Quaternion.Lerp(transform.rotation, newRotation, rotationSpeed * Time.deltaTime);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player") && boli)
        {
            Atraction();
            boli = false;
        }
    }

    private void Atraction()
    {
        gameObject.GetComponent<Rigidbody>().AddRelativeForce(new Vector3(0,1,7) * particleSpeed);
        //gameObject.GetComponent<Rigidbody>().velocity = new Vector3(player.transform.position.x, 0, player.transform.position.z) * particleSpeed;
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Player"))
        {
            //audioSource.Play();
            //collision.gameObject.GetComponent<PlayerHealthScript>().DamagePlayer(-lifeToPlayer);
            
            Destroy(gameObject);
        }
    }
}
