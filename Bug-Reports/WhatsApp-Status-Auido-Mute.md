Intermittent Audio Loss during Status Playback (Mute Regression)
================================================================

📝 Description
--------------

The audio stream for WhatsApp Status updates (video or audio-enabled posts) intermittently fails, rendering the media mute. Once the state is triggered, all subsequent Status updates remain mute regardless of volume hardware settings. The issue is only remediated by a full application restart (Force Stop/Relaunch).

🛠️ Environment & Metadata
--------------------------

*   **App Version:** WhatsApp Android (2.25.37.76)
    
*   **Device:** Xiaomi Poco C75
    
*   **OS:** Android 15 (HyperOS 2)
    
*   **Frequency:** Intermittent (~1-2 occurrences per week)
    
*   **Trigger Status:** Non-deterministic (Random)
    

👣 Steps to Reproduce
---------------------

_Note: This bug is intermittent and lacks a consistent 1:1 reproduction trigger._

1.  Open WhatsApp.
    
2.  Navigate to the **Updates** (Status) tab.
    
3.  View multiple video statuses in sequence.
    
4.  Observe that audio occasionally fails to initialise for a specific status.
    
5.  Attempt to view other statuses; observe that the "Mute" state persists across the entire module.
    

📈 Expected Behaviour
--------------------

The AudioManager should request and maintain AUDIOFOCUS\_GAIN for each media item in the status tray, releasing and re-acquiring focus between transitions.

📉 Actual Behaviour
------------------

The app enters a "Stuck Mute" state. While the system volume is high and other apps (YouTube/Netflix) produce sound, WhatsApp fails to output audio to the hardware buffer until the process is killed and restarted.

🔍 Technical Analysis & Hypotheses
----------------------------------

As this is a random occurrence, the following root causes are suspected:

*   **Race Condition:** A synchronisation error between the ExoPlayer instance and the Android AudioManager during rapid status skipping.
    
*   **Audio Focus Leak:** The app may be failing to release the audio focus of a previous "zombie" process, blocking new streams from accessing the speaker.
    
*   **Buffer Underrun:** A failure in the Xiaomi-specific audio HAL (Hardware Abstraction Layer) when transitioning between different sample rates in user-uploaded media.
    

📸 Evidence & Logs
------------------

*   **Observation:** Toggle of Physical Volume Up/Down shows the "Media" slider moving, but no output is produced.
    
*   **Logcat Requirement:** Device logs are required at the exact moment of failure to inspect AudioTrack errors or MediaCodec timeouts.
    

🔴 Severity & Priority
----------------------

*   **Severity:** **High** (Core feature functionality is lost; requires a hard restart).
    
*   **Priority:** **P2** (Requires "Watch & Log" monitoring to capture a definitive trace).
