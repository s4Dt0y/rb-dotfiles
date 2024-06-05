#include "../sketchybar.h"
#include <time.h>
#include <sys/time.h>
#include <unistd.h>

static int last_day = -1;

int main(int argc, char** argv) {
  float update_freq;
  if (argc < 3 || (sscanf(argv[2], "%f", &update_freq) != 1)) {
    printf("Usage: %s \"<event-name>\" \"<event_freq>\"\n", argv[0]);
    exit(1);
  }
  // NOTE: `update_freq` does not really work!
  update_freq = 1.0;  // Force update per second.

  alarm(0);

  const char* format = "%H:%M:%S";
  char time_buffer[64];
  char message_buffer[sizeof(time_buffer) + 64];
  for (;;) {
    struct timeval tv; gettimeofday(&tv, NULL);
    time_t current_time = tv.tv_sec;
    struct tm *local_time = localtime(&current_time);

    // Check the new day!
    if (last_day != -1 && last_day != local_time->tm_mday) sketchybar((char *)"--trigger system_woke");
    last_day = local_time->tm_mday;

    strftime(time_buffer, sizeof(time_buffer), format, local_time);
    snprintf(message_buffer, sizeof(message_buffer), "--trigger clock_update time='%s'", time_buffer);
    sketchybar(message_buffer);

    // usleep(update_freq * 1000000);
    usleep(1000000 - tv.tv_usec);
  }

  return 0;
}
