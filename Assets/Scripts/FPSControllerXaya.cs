using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FPSControllerXaya : MonoBehaviour
{
    public int velRun;

    public float velMov = 3.0f;
    public float velRot = 200.0f;
    public float x, y;
    public float forceJump=5f;
    public float velInicial;
    public float velCrouched;
    public float impulseAttack = 0.3f;

    public bool jump;
    public bool crouched;
    public bool attack;
    public bool movAttack;
    public bool swordAttack;
    public bool bowAttack; //Para arco

    public Animator animate;
    public Rigidbody rbXaya;
    public CapsuleCollider colStanding; //Colisionador cuando el personaje esta de pie
    public CapsuleCollider colCrouched; //Colisionador cuando el personaje está agachado
    public GameObject head;
    public LogicalHeadScript logicalHead;

    //
    Transform tr;
    public Transform cameraShoulder;
    public Transform cameraHolder;
    private Transform cam;
      
    
    private float rotY = 0;

    public float rotationSpeed = 200;
    public float minAngle = -45;
    public float maxAngle = 45;
    public float cameraSpeed = 200;
    //Mira
    
    
    public MovArrowSrcipt bow;

    void Start()
    {
        jump = false;
        animate= GetComponent<Animator>();

        velInicial = velMov;
        velCrouched = velMov * 0.5f;
        //
        cam = Camera.main.transform;
        tr = this.transform;
        
    }

    void FixedUpdate()
    {
        if(!attack)
        {
            transform.Rotate(0, x * Time.deltaTime * velRot, 0);
            transform.Translate(0, 0, y * Time.deltaTime * velMov);
        }
        if(movAttack)
        {
            rbXaya.velocity = transform.forward * impulseAttack;
        }
    }

    void Update()
    {
        x = Input.GetAxis("Horizontal");
        y = Input.GetAxis("Vertical");

        animate.SetFloat("VelX", x);
        animate.SetFloat("VelY", y);
         
        float mouseX = Input.GetAxis("Mouse X");
        float mouseY = Input.GetAxis("Mouse Y");
        float deltaT = Time.deltaTime;

        rotY += mouseY * rotationSpeed * deltaT;
        float rotX = mouseX * rotationSpeed * deltaT;

        tr.Rotate(0, rotX, 0);

        rotY = Mathf.Clamp(rotY, minAngle, maxAngle);

        Quaternion localRotation = Quaternion.Euler(-rotY, 0, 0);
        cameraShoulder.localRotation = localRotation;

        cam.position = Vector3.Lerp(cam.position, cameraHolder.position, cameraSpeed * deltaT);
        cam.rotation = Quaternion.Lerp(cam.rotation, cameraHolder.rotation, cameraSpeed * deltaT);

                
        if (Input.GetKey(KeyCode.K) && !crouched && jump && !attack)
        {
            velMov = velRun;
            if(y>0)
            {
                animate.SetBool("Run", true);
            }
            else
            {
                animate.SetBool("Run", false);
            }
        }
        else
        {
            animate.SetBool("Run", false);
            if(crouched)
            {
                velMov = velCrouched;
            }
            else if(jump)
            {
                velMov = velInicial;
            }
        }                

        if(Input.GetKeyDown(KeyCode.P) && jump && !attack)
        {
            if (swordAttack)
            {
                animate.SetTrigger("SwordAttack");
                attack = true;
            }
            else
            {
                animate.SetTrigger("Attack");
                attack = true;
            }
        }               

        if (Input.GetKey(KeyCode.U) && jump && !attack) //Para ataque con animacion de arco
        {
            if(bowAttack)
            {
                
                animate.SetTrigger("BowAttack");
                attack = true;
            }
            else
            {
                animate.SetTrigger("Attack");
                attack = true;
            }
        }
        if(Input.GetKeyUp(KeyCode.U) && jump && !attack) //
        {
            animate.SetTrigger("BowAttack");
            attack = false;
        }

        if(jump)
        {
            if (!attack)
            {
                animate.SetBool("Jump", false);
                if (Input.GetKeyDown(KeyCode.Space))
                {
                    animate.SetBool("Jump", true);
                    rbXaya.AddForce(new Vector3(0, forceJump, 0), ForceMode.Impulse);

                }
                if (Input.GetKey(KeyCode.Q))
                {
                    animate.SetBool("Crouched", true);
                    //velMov = velCrouched;

                    colCrouched.enabled = true;
                    colStanding.enabled = false;
                    head.SetActive(true);
                    crouched = true;

                }
                else
                {
                    if (logicalHead.timerCollider <= 0)
                    {
                        animate.SetBool("Crouched", false);
                        //velMov = velInicial;

                        head.SetActive(false);
                        colCrouched.enabled = false;
                        colStanding.enabled = true;
                        crouched = false;
                    }
                }
                //animate.SetBool("Landing", true);
            }
            animate.SetBool("Landing", true);
        }
        else
        {
            FallingDown();
        }
        //       
       
        Cursor.lockState = (Input.GetKey(KeyCode.Escape) ? CursorLockMode.None : CursorLockMode.Locked);
        //aiming = Input.GetKey(KeyCode.Mouse1);
    }

    public void FallingDown()
    {
        animate.SetBool("Landing", false);
        animate.SetBool("Jump", false);
    }
    public void StopAttack()
    {
        attack = false;        
    }
    public void MovAttack()
    {
        movAttack = true;
    }
    public void StopMov()
    {
        movAttack = false;
    }
    
    
}
