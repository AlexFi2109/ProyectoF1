using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActiveSwordScript : MonoBehaviour
{
    public TakeSwordScript takeSword;
    public int weapon;

    private void Start()
    {
        takeSword = GameObject.FindGameObjectWithTag("Player").GetComponent<TakeSwordScript>();
    }

    private void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag=="Player")
        {
            takeSword.ActiveSword(weapon);
            Destroy(gameObject);
        }
    }
}
