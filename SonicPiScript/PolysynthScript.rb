synth_choice = 0  #Default to a tri(or whatever the first synth on the list is)

#The selection math is kept seperate to allow the playback to run in a parallel fashion
live_loop :midi_switch_synth do
  use_real_time
  midi_choice_in = sync "/midi:midi_function_0:1/control_change"  #Get the Mod Wheel value to choose a synth
  synth_choice = (((midi_choice_in[1].to_f)/127)*3).to_i #Get a value between 0 and 1 and then multiply by number of synths-1 to get a number that can be used to select a synth
  print synth_choice
  midi_
end

#The live loop where the synth is actually set and played
live_loop :play_synth do
  use_real_time
  use_synth [:tri, :piano, :beep, :prophet][synth_choice] #Actually set the synth
  note, velocity = sync "/midi:midi_function_0:1/note_on" #The note variable controls the note to be played and the velocity variable controls the note amplitude
  play note if note > 0
end





