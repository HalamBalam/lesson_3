class Train
  attr_reader :number, :type, :wagons_count, :speed, :current_station

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @wagons_count = wagons_count
    @speed = 0
  end

  def up_speed(delta)
    @speed += delta
  end

  def down_speed(delta)
    @speed -= delta
    @speed = 0 if @speed < 0 
  end

  def attach_wagon
    @wagons_count += 1 if @speed == 0
  end

  def detach_wagon
    @wagons_count -= 1 if @speed == 0 && @wagons_count > 0
  end

  def set_route(route)
    @route = route
    @current_station = 0
    current_station.arrive(self)
  end

  def current_station
    @route.stations[@current_station]
  end

  def next_station
    @route.stations[@current_station + 1]
  end

  def previous_station
    @route.stations[@current_station - 1] if @current_station > 0
  end

  def go_forward
    return if next_station.nil?
    current_station.depart(self)
    next_station.arrive(self)
    @current_station += 1
  end

  def go_back
    return if previous_station.nil?
    current_station.depart(self)
    previous_station.arrive(self)
    @current_station -= 1
  end

end
