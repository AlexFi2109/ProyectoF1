using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FadeOutScript : MonoBehaviour
{
    public GameObject LifePoint;
    public int numberOfLP;
    public Vector3 offset;
    public GameObject explosionParticles;

    void Start()
    {
    }

    public void Explode(float time)
    {
        StartCoroutine(DelayExplosion(time));
    }

    private IEnumerator DelayExplosion(float time)
    {
        yield return new WaitForSeconds(time);
        SpawnLifePoints();
        Instantiate(explosionParticles, transform.position + offset, Quaternion.identity);
        Destroy(gameObject);
    }

    private void SpawnLifePoints()
    {
        for (int i = 0; i < numberOfLP; i++)
        {
            
            Instantiate(LifePoint,
                gameObject.transform.position,
                gameObject.transform.rotation);
        }

    }
}
