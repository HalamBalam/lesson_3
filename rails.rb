class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
    @trains << train
  end

  def depart(train)
    @trains.delete(train)
  end

  def cargo_trains
    trains_by_type(:cargo).size  
  end

  def passenger_trains
    trains_by_type(:passenger).size  
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end
end


class Route
  attr_reader :stations

  def initialize(start, finish)
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(-2, station) if !@stations.include?(station)
  end

  def delete_station(station)
    @stations.delete(station) if ![@stations.first, @stations.last].include?(station)
  end

  def print
    stations.each { |station| puts station.name }
  end

end


class Train
  attr_reader :number, :type, :size, :speed, :current_station

  def initialize(number, type, size)
    @number = number
    @type = type
    @size = size
    @speed = 0
  end

  def up_speed(delta)
    @speed += delta
  end

  def down_speed(delta)
    @speed -= delta
    @speed = 0 if @speed < 0 
  end

  def attach_car
    @size += 1 if @speed == 0
  end

  def detach_car
    @size -= 1 if @speed == 0 && @size > 1
  end

  def set_route(route)
    @route = route
    move_to(route.stations.first)
  end

  def next_station
    return nil if @current_station.nil?

    index = @route.stations.index(@current_station)
    return index < @route.stations.size - 1 ? @route.stations[index + 1] : nil
  end

  def previous_station
    return nil if @current_station.nil?

    index = @route.stations.index(@current_station)
    return index > 0 ? @route.stations[index - 1] : nil
  end

  def go_forward
    if !next_station.nil?
      move_to(next_station)
    end
  end

  def go_back
    if !previous_station.nil?
      move_to(previous_station)
    end
  end

  def move_to(station)
    @current_station.depart(self) if !@current_station.nil?

    @current_station = station
    @current_station.arrive(self)
  end
end
