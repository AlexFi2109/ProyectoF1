using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MonsterScript : MonoBehaviour
{
    public float vida, contador,contadorA,a;
    public float danoPunch,danoFlip,danoPunch2,danoSlash,danoJump,danoRoar,danoRecibido;
    public Animator animator;
    public int seleccionador;

    private AudioSource controlAudio;
    [SerializeField] private AudioClip[] audios;

    // Start is called before the first frame update
    void Start()
    {
        controlAudio = GetComponent<AudioSource>();
        animator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        transform.rotation = Quaternion.Euler(0, 0, 0);
        contador += Time.deltaTime;
        if(contador > 4)
        {
            contador = 0;
            a = 1;
            Ataque();
        }     
    }

    public void Ataque()
    {
        seleccionador = Random.Range(0, 2);
        contador += Time.deltaTime;
        if (seleccionador == 0)
        {
            animator.SetBool("AttackFlip", true);
            animator.SetBool("Walk", false);
            Esperar(2);
            seleccionador = Random.Range(0, 2);
            contador += Time.deltaTime;
            if (seleccionador == 0 && contador > 5)
            {
                contador = 0;
                animator.SetBool("AttackPunch2", true);

            }
            animator.SetBool("AttackPunch2", false);
        }
        animator.SetBool("AttackFlip", false);
        

        if (seleccionador == 1)
        {
            animator.SetBool("AttackPunch", true);
            animator.SetBool("Walk", false);
            Esperar(2);
            seleccionador = Random.Range(0, 3);
            contadorA = 0;
            contadorA += Time.deltaTime;
            if (seleccionador == 0 && contadorA > 2)
            {

                animator.SetBool("AttackSlash", true);
                

            }
            else if (seleccionador == 1 && contadorA > 2)
            {
                animator.SetBool("AttackJump", true);
                

            }
            else if (contadorA > 5)
            {
                animator.SetBool("AttackFlip", true);
                animator.SetBool("AttackPunch", false);
                
            }
        }
        contador = 0;
    }

    private IEnumerator Esperar(int s)
    {
        yield return new WaitForSeconds(s);
    }


}
