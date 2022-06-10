using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActiveBowScript : MonoBehaviour
{
    public TakeBowScript takeBow;
    public int weapon;

    private void Start()
    {
        takeBow = GameObject.FindGameObjectWithTag("Player").GetComponent<TakeBowScript>();
    }

    private void Update()
    {

    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            takeBow.ActiveBow(weapon);
            Destroy(gameObject);
        }
    }
}
