using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Trans_Text : MonoBehaviour
{
    //Get current material
    private Material currentMat;

    // Start is called before the first frame update
    void Start()
    {

        currentMat = gameObject.GetComponent<Renderer>().material;

    }

    // Update is called once per frame
    void Update()
    {
        float t = Mathf.InverseLerp(0f, 0.15f, gameObject.transform.position.y);
        float alpha = Mathf.Lerp(0, 1, t);
        ChangeAlpha(currentMat, alpha);
        //Debug.Log(alpha);
        //Debug.Log(gameObject.transform.position.y);
    }

    void ChangeAlpha(Material mat, float alphaVal)
    {
        Color oldColor = mat.color;
        Color newColor = new Color(oldColor.r, oldColor.g, oldColor.b, alphaVal);
        mat.SetColor("_Color", newColor);

    }
}