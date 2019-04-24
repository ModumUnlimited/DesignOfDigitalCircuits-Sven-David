# Lab Report 7

**Still work in progress**

We recycle the code from Lab 7. The problem we have is that we only have four registers to pass arguments to a subroutine. In order to fix this we only pass the stack pointer as an argument to our subroutine and pack all the data we need on our stack. 

We have also used the same data that we have already used in the Lab. Although we are now dealing with subpixels we should still see the same result in the final register - a total difference of 9 - which our code successfully does.

Our subroutine *abs_diff_color* takes the values from the stack, stores the return address on the stack and then calls *abs_diff* subroutine for each pair of subpixels of the same color. After *abs_diff* subroutine returns the *abs_diff_color* subroutine will load the next color subpixels and store the result from *abs_diff* on the stack. This happens a total of three times since we have three differently colored subpixels per pixel. 

After that *abs_diff_color* will have summed all absolute differences on the stack, place it in the first return value register and load the return address from the stack again after which it returns to the caller.

Please note that the code is heavily commented. More details can be seen there.