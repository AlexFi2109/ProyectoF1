using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyDamageScript : MonoBehaviour
{
    public int damageToPlayer;
    public int damageAttack;
    public int damageAttackSword;
    public int damageAttackBow;

    public GameObject player;
    public GameObject enemy;

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag=="Player")
        {
            player.GetComponent<XayaHealthScript>().playerHealth-= damageToPlayer;
        }
        if (other.gameObject.tag == "AttackSword")//
        {
            enemy.GetComponent<EnemyHealthScript>().enemyHealth -= damageAttackSword;
        }
        if (other.gameObject.tag == "Attack")//
        {
            enemy.GetComponent<EnemyHealthScript>().enemyHealth -= damageAttack;
        }
        if (other.gameObject.tag == "Bow")//
        {
            enemy.GetComponent<EnemyHealthScript>().enemyHealth -= damageAttackBow;
        }
    }

}
