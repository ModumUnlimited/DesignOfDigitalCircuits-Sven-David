This fixed implementation will start the sequence even if the left or right button has only quickly been pressed and does not depend on the clock.

The previous implementation only started the sequence if left or right were pressed during a positive clock edge.