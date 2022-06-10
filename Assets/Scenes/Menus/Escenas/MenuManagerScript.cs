using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuManagerScript : MonoBehaviour
{
    public AudioClip highlightedClip;
    public AudioClip pressedClip;
    public GameObject loadingImage; //2

    private void Start()
    {
        Cursor.visible = true;
        Cursor.lockState = CursorLockMode.None;
    }

    public void OnButtonHighlighted()
    {
        GetComponent<AudioSource>().PlayOneShot(highlightedClip);
    }

    public void OnButtonPressed(string sceneName)
    {
        GetComponent<AudioSource>().PlayOneShot(pressedClip);
        loadingImage.SetActive(true); //2
        StartCoroutine(DelaySceneChange(sceneName));
    }

    private IEnumerator DelaySceneChange(string sceneName)
    {
        yield return new WaitForSeconds(1);
        SceneManager.LoadScene(sceneName, LoadSceneMode.Single);
    }

    private IEnumerator DelayQuit()
    {
        yield return new WaitForSeconds(1);
        Application.Quit();
    }

    public void OnQuitPressed()
    {
        GetComponent<AudioSource>().PlayOneShot(pressedClip);
        StartCoroutine(DelayQuit());
    }
}
