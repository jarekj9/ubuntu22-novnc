    <script>
      window.onload = function() {
        var endTimeString = "2024-01-01T10:00:00Z";
        var endTime = new Date(endTimeString);
  
        var countdown = setInterval(function() {
          var now = new Date().getTime();
          var distance = endTime.getTime() - now;
  
          var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
          var seconds = Math.floor((distance % (1000 * 60)) / 1000);
  
          document.getElementById("timer").innerHTML = minutes + "m " + seconds + "s ";
  
          if (distance < 0) {
            clearInterval(countdown);
            document.getElementById("timer").innerHTML = "EXPIRED";
          }
        }, 1000);
      }
    </script>
