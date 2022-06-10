using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TakeSwordScript : MonoBehaviour
{
    public GameObject[] sword;
    public FPSControllerXaya logicalXaya;
    public BoxCollider[] swordAttackCollider;
    public BoxCollider attackCollider;

    private void Start()
    {
        DisableCollidersAttack();
    }
    private void Update()
    {
        if(Input.GetKeyDown(KeyCode.E))
        {
            DisableSword();
        }
    }

    public void ActiveSword(int number)
    {
        for(int i=0;i<sword.Length;i++)
        {
            sword[i].SetActive(false);
        }
        sword[number].SetActive(true);

        logicalXaya.swordAttack = true;
        
    }
    public void DisableSword()
    {
        for (int i = 0; i < sword.Length; i++)
        {
            sword[i].SetActive(false);
        }
        logicalXaya.swordAttack = false;
        
    }
    public void ActiveCollidersAttack()
    {
        for(int i=0; i<swordAttackCollider.Length; i++)
        {
            if(logicalXaya.swordAttack)
            {
                if(swordAttackCollider[i]!=null)
                {
                    swordAttackCollider[i].enabled = true;
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
        for(int i=0; i<swordAttackCollider.Length; i++)
        {
            if(swordAttackCollider[i]!= null)
            {
                swordAttackCollider[i].enabled = false;
            }
        }
        attackCollider.enabled = false;
    }
}
