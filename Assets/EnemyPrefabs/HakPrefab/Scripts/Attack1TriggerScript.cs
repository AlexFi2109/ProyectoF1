using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Attack1TriggerScript : MonoBehaviour
{
    private void OnTriggerStay(Collider other)
    {

        if (other.gameObject.CompareTag("Player"))
        {
            GetComponentInParent<HakScript>().magicAttack = false;
            GetComponentInParent<HakScript>().isMagicAttacking = false;
            GetComponentInParent<HakScript>().attack2 = false;
            GetComponentInParent<HakScript>().isAttacking2 = false;
            GetComponentInParent<HakScript>().attack1 = true;
        }  
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            GetComponentInParent<HakScript>().attack1 = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            GetComponentInParent<HakScript>().attack1 = false;
        }
    }
}
