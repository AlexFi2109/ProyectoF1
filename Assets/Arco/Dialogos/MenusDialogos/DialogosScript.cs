using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DialogosScript : MonoBehaviour
{
    // Start is called before the first frame update

    public GameObject panel, player;
    public GameObject txt1, txt2, txt3, txt4, txt5;
    public GameObject Emisor;
    public AudioSource controlAudio;
    [SerializeField] private AudioClip[] audios;

    void Start()
    {
        panel.SetActive(false);
        txt1.SetActive(false);
        txt2.SetActive(false);
        txt3.SetActive(false);
        txt4.SetActive(false);
        txt5.SetActive(false);

        Emisor = GameObject.Find("Main Camera");
        controlAudio = Emisor.GetComponent<AudioSource>();
        controlAudio.PlayOneShot(audios[0], 0.5f);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Txt1"))
        {
            panel.SetActive(true);
            txt1.SetActive(true);
            txt2.SetActive(false);
            txt3.SetActive(false);
            txt4.SetActive(false);
            txt5.SetActive(false);
            StartCoroutine(Esperar(4));
        }
        else if (other.CompareTag("Txt2"))
        {
            controlAudio.Stop();
            controlAudio.PlayOneShot(audios[1], 0.5f);
            panel.SetActive(true);
            txt1.SetActive(false);
            txt2.SetActive(true);
            txt3.SetActive(false);
            txt4.SetActive(false);
            txt5.SetActive(false);
            StartCoroutine(Esperar(4));
        }
        else if (other.CompareTag("Txt3"))
        {
            controlAudio.Stop();
            controlAudio.PlayOneShot(audios[2], 0.5f);
            panel.SetActive(true);
            txt1.SetActive(false);
            txt2.SetActive(false);
            txt3.SetActive(true);
            txt4.SetActive(false);
            txt5.SetActive(false);
            StartCoroutine(Esperar(4));
        }
        else if (other.CompareTag("Txt4"))
        {
            panel.SetActive(true);
            txt1.SetActive(false);
            txt2.SetActive(false);
            txt3.SetActive(false);
            txt4.SetActive(true);
            txt5.SetActive(false);
            StartCoroutine(Esperar2(6));
                        
        }
        else if (other.CompareTag("Txt5"))
        {
            controlAudio.Stop();
            controlAudio.PlayOneShot(audios[3], 0.5f);

        }
        else if (Input.GetKeyDown("r"))
        {
            panel.SetActive(false);
            txt1.SetActive(false);
            txt2.SetActive(false);
            txt3.SetActive(false);
            txt4.SetActive(false);
            txt5.SetActive(false);
        }
    }

    private IEnumerator Esperar(float time)
    {
        yield return new WaitForSeconds(time);
        panel.SetActive(false);
        txt1.SetActive(false);
        txt2.SetActive(false);
        txt3.SetActive(false);
        txt4.SetActive(false);
        txt5.SetActive(false);
    }
    private IEnumerator Esperar2(float time)
    {
        yield return new WaitForSeconds(time);
        panel.SetActive(true);
        txt1.SetActive(false);
        txt2.SetActive(false);
        txt3.SetActive(false);
        txt4.SetActive(false);
        txt5.SetActive(true);
        StartCoroutine(Esperar(6));
    }

}
