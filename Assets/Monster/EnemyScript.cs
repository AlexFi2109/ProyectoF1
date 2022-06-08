using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyScript : MonoBehaviour
{
    public int caso;
    public float contador;
    public Animator animator;
    public float danoPunch, danoFlip, danoPunch2, danoSlash, danoJump, danoRoar, vida;
    public float damageArrow, damageSword;

    public GameObject objetivo;

    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
        objetivo = GameObject.Find("Xaya");
    }

    // Update is called once per frame
    void Update()
    {
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
           // Destroy(gameObject);

        }

    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Arrow") )
        {
            
            vida -= damageArrow/2;
            //Destroy(gameObject, 1f);
        }
              
    }

    private void OnTriggerStay(Collider other)
    {
        if (other.CompareTag("Player"))
        {

            Ataque();
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

