using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DissapearWithMagicScript : MonoBehaviour
{
    public Vector3 offset;
    public GameObject explosionParticles;

    public void Dissapear(float time)
    {
        StartCoroutine(DelayExplosion(time));
    }

    private IEnumerator DelayExplosion(float time)
    {
        yield return new WaitForSeconds(time);
        Instantiate(explosionParticles, transform.position + offset, Quaternion.identity);
        SceneManager.LoadScene("CreditsScene", LoadSceneMode.Single);
        Destroy(gameObject);
    }
}
