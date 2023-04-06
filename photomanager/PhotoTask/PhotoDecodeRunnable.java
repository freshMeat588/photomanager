package com.example.photomanager.PhotoTask;

import android.graphics.Bitmap;

class PhotoDecodeRunnable implements Runnable{

    interface TaskRunnableDecodeMethods{

        /**
         * Sets the Thread that this instance is running on
         * @param currentThread the current Thread
         */
        void setImageDecodeThread(Thread currentThread);

        /**
         * Returns the current contents of the download buffer
         * @return The byte array downloaded from the URL in the last read
         */
        byte[] getByteBuffer();

        /**
         * Sets the actions for each state of the PhotoTask instance.
         * @param state The state being handled.
         */
        void handleDecodeState(int state);

        /**
         * Returns the desired width of the image, based on the ImageView being created.
         * @return The target width
         */
        int getTargetWidth();

        /**
         * Returns the desired height of the image, based on the ImageView being created.
         * @return The target height.
         */
        int getTargetHeight();

        /**
         * Sets the Bitmap for the ImageView being displayed.
         * @param image
         */
        void setImage(Bitmap image);

    }

    @Override
    public void run() {

    }
}
