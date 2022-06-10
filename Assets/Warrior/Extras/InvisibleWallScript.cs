using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InvisibleWallScript : MonoBehaviour
{
    public GameObject enemie1;
    public GameObject enemie2;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (enemie1.GetComponent<EnemyHealthScript>().enemyHealth <= 0 &&
            enemie2.GetComponent<EnemyHealthScript>().enemyHealth <= 0)
        {
            Destroy(gameObject);
        }
    }
}
