using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ExplodeWhenDieScript : MonoBehaviour
{
    public Vector3 offset;
    public GameObject explosionParticles;

    public void Explode(float time)
    {
        StartCoroutine(DelayExplosion(time));
    }

    private IEnumerator DelayExplosion (float time)
    {
        yield return new WaitForSeconds(time);
        Instantiate(explosionParticles, transform.position + offset,Quaternion.identity);
        Destroy(gameObject);
    }
}
