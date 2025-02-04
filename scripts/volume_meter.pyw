#!/usr/bin/env python3

import os
import sys
import atexit

import sounddevice as sd
import numpy as np
import librosa

import tkinter as tk
from tkinter import messagebox
from tkinter import font
import pystray
from PIL import Image, ImageDraw
import threading
import time
import tempfile

env = "work"
#env = "home"

if env == "work":
    # Work
    volume_wrn_threshold = 30
    volume_err_threshold = 35
    volume_correction = 0
else:
    # Home
    volume_wrn_threshold = 60
    volume_err_threshold = 65
    volume_correction = 20


############################################################################################
# Verify only one instance

############################################################################################
# Volume
def measure_background_noise(duration=2, sample_rate=44100):
    #print("Measuring background noise...")
    recording = sd.rec(int(duration * sample_rate), samplerate=sample_rate, channels=1) #, dtype='float64')
    sd.wait()
    rms = np.sqrt(np.mean(np.square(recording)))
    return rms

def measure_sound_level(background_noise_level):
    duration = 2  # seconds
    sample_rate = 44100
    recording = sd.rec(int(duration * sample_rate), samplerate=sample_rate, channels=1) #, dtype='float64')
    sd.wait()

    ###########################################################
    #recording = recording.flatten()
    #rms = librosa.feature.rms(y=recording)[0]
    #decibels = librosa.amplitude_to_db(rms, ref=np.max) + volume_correction
    #return decibels[0]
    ###########################################################

    rms = np.sqrt(np.mean(np.square(recording)))
    decibels = 20 * np.log10(rms / background_noise_level)
    return decibels

############################################################################################
# UI
def create_image(color = "black"):

    image = Image.new('RGB', (64, 64), (0, 0, 0))
    draw = ImageDraw.Draw(image)
    if color == "yellow":
        draw.ellipse((0, 0, 64, 64), fill=(255, 255, 0), outline=(0, 255, 0), width=5)
    elif color == "red":
        draw.ellipse((0, 0, 64, 64), fill=(255, 0, 0), outline=(0, 255, 0), width=5)
    else:
        draw.ellipse((0, 0, 64, 64), fill=(0, 0, 0), outline=(0, 255, 0), width=5)
    # Create an image with a yellow and red circle
    return image

class MyApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Sound Level Meter")
        self.geometry('150x60')

        self.label_font = font.Font(family="Helvetica", size=20)
        self.label = tk.Label(self, text="Init", font=self.label_font)
        self.background_noise_level = 0
        self.label.pack(pady=20)
        self.resizable(False, False)
        #self.protocol('WM_DELETE_WINDOW', self.minimize_to_tray)
        self.resizable(False, False)

        self.x = 0
        self.y = 0
        self.bind("<Button-1>", self.start_move)
        self.bind("<B1-Motion>", self.do_move)
        self.bind("<Up>", self.move_up)
        self.bind("<Down>", self.move_down)
        self.bind("<Left>", self.move_left)
        self.bind("<Right>", self.move_right)


        self.running = True
        self.update_sound_level()

    def update_sound_level(self):
        if self.running:
            if self.background_noise_level == 0:
                self.background_noise_level = measure_background_noise()
                decibels = 0
                label_text="BG:" + "{:.5f}".format(self.background_noise_level)
            else:
                decibels = measure_sound_level(self.background_noise_level)
                label_text="{:.2f}".format(decibels)+" dB"

            background_color="green"
            if decibels > volume_err_threshold:
                background_color = "red"
            elif decibels > volume_wrn_threshold:
                background_color = "yellow"

            self.configure(bg=background_color)
            self.label.config(text=label_text, font=self.label_font, bg=background_color)
            self.after(1000, self.update_sound_level)

    def minimize_to_tray(self):
        self.withdraw()

    def quit_window(self, item):
        self.running = False
        self.destroy()

    def show_window(self, item):
        self.after(0, self.deiconify)

    def start_move(self, event):
        self.x = event.x
        self.y = event.y

    # Move - with arrow
    def do_move(self, event):
        x = self.winfo_pointerx() - self.x
        y = self.winfo_pointery() - self.y
        self.geometry(f"+{x}+{y}")

    # Move - with arrow
    def move_up(self, event):
        x = self.winfo_x()
        y = self.winfo_y()
        self.geometry(f"+{x}+{y-10}")

    def move_down(self, event):
        x = self.winfo_x()
        y = self.winfo_y()
        self.geometry(f"+{x}+{y+10}")

    def move_left(self, event):
        x = self.winfo_x()
        y = self.winfo_y()
        self.geometry(f"+{x-10}+{y}")

    def move_right(self, event):
        x = self.winfo_x()
        y = self.winfo_y()
        self.geometry(f"+{x+10}+{y}")


############################################################################################
def delete_lock_file():
    if os.path.exists(lock_file):
        os.remove(lock_file)

if __name__ == "__main__":

    lock_file = os.path.join(tempfile.gettempdir(), "volume_meter.lock")
    if os.path.exists(lock_file):
        messagebox.showerror("Error", "Another inastance already running.")
        sys.exit()

    open(lock_file, "w").close()
    atexit.register(delete_lock_file)

    app = MyApp()
    app.mainloop()

