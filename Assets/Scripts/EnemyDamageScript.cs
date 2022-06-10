using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyDamageScript : MonoBehaviour
{
    public int damageToPlayer=10;
    public GameObject player;

    void Start()
    {
        
        player = GameObject.Find("Xaya");
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag=="Player")
        {
            player.GetComponent<PlayerHealthScript>().DamagePlayer(damageToPlayer);
            
        }        
    }

}
