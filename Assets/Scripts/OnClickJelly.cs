using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class OnClickJelly : MonoBehaviour {
	public float maxDelta = 20.0f;
	private float delta;
	public SpriteRenderer sr;

	void Start(){
		delta = maxDelta;
	}
	
	void Update () {
		if (delta > 0) {
			sr.material.SetFloat ("_Delta", delta);
			delta -= 0.1f;

		}
	}

	void OnMouseDown(){
		delta = maxDelta;
		Debug.Log ("Click jelly " + delta);
	}

}
