using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dialogo1Script : MonoBehaviour
{
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
            StartCoroutine(Esperar(4));
        }
    }

    private IEnumerator Esperar(float time)
    {
        yield return new WaitForSeconds(time);
        Destroy(gameObject);
    }

}
