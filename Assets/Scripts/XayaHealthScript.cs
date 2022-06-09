using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class XayaHealthScript : MonoBehaviour
{
    public int playerHealth = 150;

    void Start()
    {
        
    }
    
    void Update()
    {
        
    }
    public void DamagePlayer(int damageToPlayer)
    {
        playerHealth -= damageToPlayer;        
        
        if (playerHealth <= 0)
        {
            //Menu de Game Over
        }
    }
}
