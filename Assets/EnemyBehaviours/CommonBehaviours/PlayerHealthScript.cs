using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class PlayerHealthScript : MonoBehaviour
{
    public int playersHealth = 100;
    public Image lifeBar;
    public AudioClip healClip;
    public AudioClip[] hitClips;
    public GameObject deadImage;

    private AudioSource audioSource;

    void Start()
    {
        audioSource = GetComponent<AudioSource>();
        lifeBar.fillAmount = (float)playersHealth / 100f;
    }

    public void DamagePlayer(int damageToPlayer)
    {
        playersHealth -= damageToPlayer;
        int hitClipIndex = Random.Range(0, hitClips.Length);

        if(!audioSource.isPlaying)
        {
            audioSource.PlayOneShot(hitClips[hitClipIndex]);
        }
        
        lifeBar.fillAmount = (float)playersHealth / 100f;

        if (playersHealth <= 0)
        {
            deadImage.SetActive(true);
            StartCoroutine(DelaySceneChange());
        }
    }

    public void HealPlayer(int heal)
    {
        playersHealth += heal;
        playersHealth = Mathf.Clamp(playersHealth,0, 100);
        audioSource.PlayOneShot(healClip);
        lifeBar.fillAmount = (float)playersHealth / 100f;
    }

    private IEnumerator DelaySceneChange()
    {
        yield return new WaitForSeconds(1.2f);
        //SceneManager.LoadScene("17.- DeadScene", LoadSceneMode.Single);
    }

    

}
