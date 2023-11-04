'use strict';

import * as THREE from 'three';
import { MTLLoader } from 'three/examples/jsm/loaders/MTLLoader';
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader';
import { WEBGL } from 'three/examples/jsm/WebGL';
import { Viewport } from 'virtex3d';

// Init is passed as a callback (since it needs to execute after the
// viewer is shown and there is available width to calculate canvas size)
// That means "this" does not end being the right thing and we need to encapsulate the functionality here
function init() {
  global.THREE = {
    OBJLoader: OBJLoader,
    MTLLoader: MTLLoader,
    ...THREE
  };

  // Virtex uses a global Detector.  Three refactored this into the WEBGL library (and changed the API)
  // This is compatibility layer between what Vitex expects from the old Detector to the new WEBGL library.
  global.Detector = {
    webgl: WEBGL.isWebGLAvailable(),
    addGetWebGLMessage: WEBGL.getErrorMessage,
  };

  var viewer = document.getElementById('virtex-3d-viewer');
  new Viewport({
    target: viewer,
    data: {
        file: viewer.dataset.file,
        fullscreenEnabled: true,
        showStats: false,
    }
  });
}

document.addEventListener("DOMContentLoaded", init);
