using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlechaScript : MonoBehaviour
{
    public float h;
    public float damageArrow;
    public GameObject monster;

    // Start is called before the first frame update
    void Start()
    {
        h = GetComponent<Transform>().position.y;
    }

    // Update is called once per frame
    void Update()
    {
        if (h<=-2)
        {
            Destroy(gameObject);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag == "HeadMonster")
        {
            
            monster.GetComponent<EnemyScript>().vida = damageArrow;
            monster.GetComponent<EnemyScript>().RecibeDaño(damageArrow + 5);
            Destroy(gameObject,5f);
        }
        else if (other.tag == "BodyMonster"|| other.tag == "LegMonster" || other.tag == "ArmMonster")
        {
            monster.GetComponent<EnemyScript>().vida = damageArrow;
            monster.GetComponent<EnemyScript>().RecibeDaño(damageArrow);
            Destroy(gameObject,5f);
        }
        //Destroy(gameObject);
    }

}
