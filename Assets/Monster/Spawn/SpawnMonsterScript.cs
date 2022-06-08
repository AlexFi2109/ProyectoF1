using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnMonsterScript : MonoBehaviour
{
    public GameObject monsterPrefab;
    public GameObject monsterSpawnPoint;
    private GameObject monster;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            monster = Instantiate(monsterPrefab, monsterSpawnPoint.transform.position, monsterSpawnPoint.transform.rotation);
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            Destroy(gameObject);    
        }
    }

}
