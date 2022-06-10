using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TakeBowScript : MonoBehaviour
{
    public GameObject[] bow;
    public FPSControllerXaya logicalXaya;
    public BoxCollider[] bowAttackCollider;
    public BoxCollider attackCollider;

    private void Start()
    {
        DisableCollidersAttack();
    }
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.E))
        {
            DisableBow();
        }
    }

    public void ActiveBow(int number)
    {
        for (int i = 0; i < bow.Length; i++)
        {
            bow[i].SetActive(false);
        }
        bow[number].SetActive(true);
        
        logicalXaya.bowAttack = true; 
    }
    public void DisableBow()
    {
        for (int i = 0; i < bow.Length; i++)
        {
            bow[i].SetActive(false);
        }
       
        logicalXaya.bowAttack = false; 
    }
    public void ActiveCollidersAttack()
    {
        for (int i = 0; i < bowAttackCollider.Length; i++)
        {
            if (logicalXaya.swordAttack)
            {
                if (bowAttackCollider[i] != null)
                {
                    bowAttackCollider[i].enabled = true;
                }
            }
            else
            {
                attackCollider.enabled = true;
            }
        }
    }
    public void DisableCollidersAttack()
    {
        for (int i = 0; i < bowAttackCollider.Length; i++)
        {
            if (bowAttackCollider[i] != null)
            {
                bowAttackCollider[i].enabled = false;
            }
        }
        attackCollider.enabled = false;
    }
}
