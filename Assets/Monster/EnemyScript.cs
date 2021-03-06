using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyScript : MonoBehaviour
{
    public int caso;
    public float contador;
    public Animator animator;
    public float danoPunch, danoFlip, danoPunch2, danoSlash, danoJump, danoRoar, vida;
    public float damageArrow, damageSword, speed;

    public GameObject objetivo;
    private AudioSource controlAudio;
    [SerializeField] private AudioClip[] audios;

    // Start is called before the first frame update
    void Start()
    {
        controlAudio = GetComponent<AudioSource>();
        animator = GetComponent<Animator>();
        objetivo = GameObject.Find("Xaya");
        controlAudio.PlayOneShot(audios[1], 0.5f); //Grito
    }

    // Update is called once per frame
    void Update()
    {
        transform.rotation = Quaternion.Euler(0, 0, 0);
        if (vida <= 0)
        {
            animator.SetBool("AttackPunch", false);
            animator.SetBool("AttackFlip", false);
            animator.SetBool("AttackPunch2", false);
            animator.SetBool("AttackSlash", false);
            animator.SetBool("AttackJump", false);
            animator.SetBool("Walk", false);
            animator.SetBool("Reaction", false);
            animator.SetBool("Death", true);
            controlAudio.PlayOneShot(audios[4], 0.5f); //Muerte
            controlAudio.mute = true;
            // Destroy(gameObject);

        }
        else if(Vector3.Distance(transform.position, objetivo.transform.position)<50)
        {
            var lookPos = objetivo.transform.position - transform.position;
            lookPos.y = 0;
            var rotation = Quaternion.LookRotation(lookPos);
            transform.rotation = Quaternion.RotateTowards(transform.rotation, rotation, 360);
            transform.position = Vector3.MoveTowards(transform.position,objetivo.transform.position, speed*Time.deltaTime);
        }
        //transform.position = Vector3.MoveTowards(transform.position, objetivo.transform.position, speed * Time.deltaTime);


    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Arrow") )
        {
            
            vida -= damageArrow/2;
            controlAudio.PlayOneShot(audios[3], 0.5f); //Damage
            //Destroy(gameObject, 1f);
        }
              
    }

    private void OnTriggerStay(Collider other)
    {
        if (other.CompareTag("Player"))
        {

            Ataque();
            controlAudio.PlayOneShot(audios[2], 0.5f); //Ataque
        }
        
    }

    private void OnTriggerExit(Collider other)
    {
        animator.SetBool("AttackPunch", false);
        animator.SetBool("AttackFlip", false);
        animator.SetBool("AttackPunch2", false);
        animator.SetBool("AttackSlash", false);
        animator.SetBool("AttackJump", false);
        animator.SetBool("Walk", true);
        controlAudio.PlayOneShot(audios[0], 0.5f); //Caminando
    }

    private void Ataque()
    {
        contador += Time.deltaTime;
        if (contador >= 1.5)
        {
            caso = Random.Range(1, 6);
            contador = 0;
        }
        switch (caso)
        {
            case 0:
                animator.SetBool("AttackPunch", false);
                animator.SetBool("AttackFlip", false);
                animator.SetBool("AttackPunch2", false);
                animator.SetBool("AttackSlash", false);
                animator.SetBool("AttackJump", false);
                animator.SetBool("Walk", true);
                break;

            case 1:
                animator.SetBool("AttackPunch", false);
                animator.SetBool("AttackFlip", true);
                animator.SetBool("AttackPunch2", false);
                animator.SetBool("AttackSlash", false);
                animator.SetBool("AttackJump", false);
                animator.SetBool("Walk", false);
                break;

            case 2:
                animator.SetBool("AttackPunch", true);
                animator.SetBool("AttackFlip", false);
                animator.SetBool("AttackPunch2", false);
                animator.SetBool("AttackSlash", false);
                animator.SetBool("AttackJump", false);
                animator.SetBool("Walk", false);
                break;
            case 3:
                animator.SetBool("AttackPunch", false);
                animator.SetBool("AttackFlip", false);
                animator.SetBool("AttackPunch2", true);
                animator.SetBool("AttackSlash", false);
                animator.SetBool("AttackJump", false);
                animator.SetBool("Walk", false);
                break;
            case 4:
                animator.SetBool("AttackPunch", false);
                animator.SetBool("AttackFlip", false);
                animator.SetBool("AttackPunch2", false);
                animator.SetBool("AttackSlash", true);
                animator.SetBool("AttackJump", false);
                animator.SetBool("Walk", false);
                break;
            case 5:
                animator.SetBool("AttackPunch", false);
                animator.SetBool("AttackFlip", false);
                animator.SetBool("AttackPunch2", false);
                animator.SetBool("AttackSlash", false);
                animator.SetBool("AttackJump", true);
                animator.SetBool("Walk", false);
                break;
        }
    }

    public void RecibeDaño(float danoRecibido)
    {
        vida = vida - danoRecibido;
        
        if(danoRecibido >= 25) //El valor puede aumentar dependiendo 
        {
            
            animator.SetBool("AttackPunch", false);
            animator.SetBool("AttackFlip", false);
            animator.SetBool("AttackPunch2", false);
            animator.SetBool("AttackSlash", false);
            animator.SetBool("AttackJump", false);
            animator.SetBool("Walk", false);
            animator.SetBool("Reaction", true);
        }        
    }
    private IEnumerator Esperar(int s)
    {
        yield return new WaitForSeconds(s);
    }
}

