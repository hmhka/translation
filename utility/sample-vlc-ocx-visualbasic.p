 DEFINE VARIABLE chVlc   AS COM-HANDLE NO-UNDO.

 create "AXVLC.VLCPlugin2" chVlc.

  
  

/*
Dim vlcControl As Object
Dim WithEvents vlcPlayer As AXVLC.VLCPlugin2

Private Sub Form_Load()
    
    Set vlcControl = Controls.Add("VideoLAN.VLCPlugin.2", "vlcControl")
    
    vlcControl.Height = 6000
    vlcControl.Width = 10000
    vlcControl.Visible = True
    
    Set vlcPlayer = vlcControl.object
    
    ' Prefix local files with file:// ie. "file://C:/video.mp4" (thanks Nanni)
    vlcPlayer.playlist.Add ("http://url.com/video.mp4")
    vlcPlayer.playlist.play
End Sub


Private Sub vlcPlayer_MediaPlayerPlaying()
    Debug.Print "Playing"
End Sub

Private Sub vlcPlayer_MediaPlayerEndReached()
    Debug.Print "Stopped"
End Sub

*/

/*
Dim vlcControl As Object

Private Sub Form_Load()
    
    Set vlcControl = Controls.Add("VideoLAN.VLCPlugin.2", "vlcControl")
    
    vlcControl.Height = 6000
    vlcControl.Width = 10000
    vlcControl.Visible = True
    
    
    ' Prefix local files with file:// ie. "file://C:/video.mp4" (thanks Nanni)
    vlcControl.object.playlist.Add ("http://url.com/video.mp4")
    vlcControl.object.playlist.play
End Sub
*/