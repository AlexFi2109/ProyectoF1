using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControlAudiosXayaScript : MonoBehaviour
{
    [SerializeField] private AudioClip[] audios;
    private AudioSource controlAudio;

    // Start is called before the first frame update
    void Start()
    {
        controlAudio = GetComponent<AudioSource>();
        //controlAudio.PlayOneShot(audios[0], 0.5f); //MusicaInicio
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Txt2"))
        {
            controlAudio.enabled = false;
            //controlAudio.enabled = true;
            controlAudio.PlayOneShot(audios[1], 0.5f); //MusicaPeleaenemigos
            
        }
        else if (other.CompareTag("Txt3"))
        {
            controlAudio.enabled = false;
            controlAudio.enabled = true;
            controlAudio.PlayOneShot(audios[2], 0.5f); //MusicaMisterio
        }
        else if (other.CompareTag("Txt5"))
        {
            controlAudio.enabled = false;
            controlAudio.enabled = true;
            controlAudio.PlayOneShot(audios[3], 0.5f); //MusicaPeleaJefe
        }
        else if (other.CompareTag("Txt6"))
        {
            controlAudio.enabled = false;
            controlAudio.enabled = true;
            controlAudio.PlayOneShot(audios[4], 0.5f); //MusicaPeleaJefeFinal
        }

    }

}
