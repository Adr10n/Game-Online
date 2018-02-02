module Map

class Room 
    def initialize(name, description)
        @name = name
        @description = description
        @paths = {}
    end 
    
    #these make it easier to access the variables
    attr_reader :name
    attr_reader :paths
    attr_reader :description
    
    def go(direction)
        return @paths[direction]
    end 
    
    def add_paths(paths)
        @paths.update(paths)
    end
end


    SCORPION = Room.new("Scorpion",
    """
   You walk bleeding and struggling and then you stumble upon a scorpion, he makes
    a move to sting you.
    """)


   POLARBEAR = Room.new("Polarbear ",
    """
  there is a polar bear in the jungle, so trust me it is angry, 
  but he is a robotic bear with a bomb, in order to escape you must diffuse the bomb with
  a special code. get the bomb.  The code is 3 digits.
    """)


    WATERFALL = Room.new("Waterfall",
    """
    You burst onto the bridge with the netron destruct bomb
    under your arm and surprise 5 rabid wolfs who are trying to
    take ravage the ship. The each have a gun 
    and want to shoot your brains off.
    """)


    RAFT= Room.new("Raft",
    """
    You rush through the ship desperately trying to make it to
    the the raft to escape down the river before the whole ship explodes.
    You get to the chamber with the rafts, and
    now need to pick one to take.  Some of them could be damaged
    but you don't have time to look.  There's 5 rafts, which one
    do you take?
    """)
     THE_END_WINNER = Room.new("The End",
    """
    You jump into raft 2 and go smoothely down the river. You see the ship above
    explode with the neutron bomb. Congrats, You won!
    """)


    THE_END_LOSER = Room.new("The End",
    """
    You jump into a random raft and hit the eject button.
    The raft escapes out into the void of space, then
    implodes as the hull ruptures, crushing your body
    into jam jelly.
    """)
    
      YOU_DIED = Room.new("YOU_DIED",
      """
      Play again.
      """)
    
        RAFT.add_paths({
        '2' => THE_END_WINNER,
        '*' => THE_END_LOSER
    })

  

    WATERFALL.add_paths({
        'throw the bomb' => YOU_DIED,
        'Give them food' => RAFT
    })

    POLARBEAR.add_paths({
        '0132' => WATERFALL,
        '*' => YOU_DIED
    })

    SCORPION.add_paths({
        'shoot!' => YOU_DIED,
        'dodge!' => YOU_DIED,
        'run' => POLARBEAR
    })

    START = SCORPION
    
      # A whitelist of allowed room names. We use this so that
    # bad people on the internet can't access random variables
    # with names.  You can use Test::constants and Kernel.const_get
    # too.
    ROOM_NAMES = {
        'Scorpion' => SCORPION,
        'Polarbear' => POLARBEAR,
        'WATERFALL' => WATERFALL,
        'RAFT' => RAFT,
        'THE_END_WINNER' => THE_END_WINNER,
        'THE_END_LOSER' => THE_END_LOSER,
        'START' => START,
        'YOU_DIED' => YOU_DIED
    }

    def Map::load_room(session)
        # Given a session this will return the right room or nil
        return ROOM_NAMES[session[:room]]
    end

    def Map::save_room(session, room)
        # Store the room in the session for later, using its name
        session[:room] = ROOM_NAMES.key(room)
    end
end