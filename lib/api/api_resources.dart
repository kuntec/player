class APIResources {
  static final String BASE_URL = "https://lotussoft.in/player/api/";
  static final String IMAGE_URL = "https://lotussoft.in/player/storage/app/";
  static final String AVATAR_IMAGE =
      "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png";

  static final String GET_PLAYER = BASE_URL + "getPlayer";
  static final String GET_PLAYER_BY_ID = BASE_URL + "getPlayerById";
  static final String ADD_PLAYER = BASE_URL + "addPlayer";
  static final String CHECK_PLAYER = BASE_URL + "checkPlayer";
  static final String UPDATE_PLAYER = BASE_URL + "updatePlayer";

  static final String ADD_PLAYER_SPORT = BASE_URL + "addPlayerSport";

  static final String UPDATE_PLAYER_IMAGE = BASE_URL + "updatePlayerImage";

  static final String GET_HOST_ACTIVITY = BASE_URL + "getHostActivity";
  static final String GET_MY_HOST_ACTIVITY = BASE_URL + "getMyHostActivity";
  static final String ADD_HOST_ACTIVITY = BASE_URL + "addHostActivity";
  static final String UPDATE_HOST_ACTIVITY = BASE_URL + "updateHostActivity";

  static final String GET_LOOKING_FOR = BASE_URL + "getLookingFor";
  static final String GET_SPORT = BASE_URL + "getSport";
  static final String GET_PLAYER_SPORT = BASE_URL + "getPlayerSport";

  static final String GET_TOURNAMENT = BASE_URL + "getTournament";
  static final String ADD_TOURNAMENT = BASE_URL + "addTournament";
  static final String UPDATE_TOURNAMENT = BASE_URL + "updateTournament";
  static final String UPDATE_TOURNAMENT_IMAGE =
      BASE_URL + "updateTournamentImage";
  static final String GET_MY_TOURNAMENT = BASE_URL + "getMyTournament";

  static final String GET_EVENT = BASE_URL + "getEvent";
  static final String ADD_EVENT = BASE_URL + "addEvent";
  static final String UPDATE_EVENT = BASE_URL + "updateEvent";
  static final String UPDATE_EVENT_IMAGE = BASE_URL + "updateEventImage";
  static final String GET_MY_EVENT = BASE_URL + "getMyEvent";

  static final String GET_SERVICE = BASE_URL + "getService";

  static final String GET_VENUE = BASE_URL + "getVenue";
  static final String GET_MY_VENUE = BASE_URL + "getMyVenue";
  static final String ADD_VENUE = BASE_URL + "addVenue";

  static final String GET_TIMESLOT = BASE_URL + "getTimeslot";
  static final String ADD_TIMESLOT = BASE_URL + "addTimeslot";
  static final String DELETE_TIMESLOT = BASE_URL + "deleteTimeslot";

  static final String GET_VENUE_PHOTO = BASE_URL + "getVenuePhoto";
  static final String ADD_VENUE_PHOTO = BASE_URL + "addVenuePhoto";
  static final String DELETE_VENUE_PHOTO = BASE_URL + "deleteVenuePhoto";

  static final String GET_SERVICEDATA_ID = BASE_URL + "getServiceById";
  static final String GET_PLAYER_SERVICEDATA =
      BASE_URL + "getServiceByPlayerId";
  static final String ADD_SERVICEDATA = BASE_URL + "addServiceData";
  static final String GET_SERVICEDATA = BASE_URL + "getServiceData";

  static final String GET_SERVICE_PHOTO = BASE_URL + "getServicePhoto";
  static final String ADD_SERVICE_PHOTO = BASE_URL + "addServicePhoto";
  static final String DELETE_SERVICE_PHOTO = BASE_URL + "deleteServicePhoto";

  static final String ADD_DAY_SLOT = BASE_URL + "addDaySlot2";
  static final String GET_DAY_SLOT = BASE_URL + "getDaySlot";
  static final String UPDATE_DAY_SLOT = BASE_URL + "updateDaySlot2";

  static final String GET_DAY_TIME_SLOT = BASE_URL + "getDayTimeSlot";
  static final String UPDATE_DAY_TIME_SLOT = BASE_URL + "updateDayTimeSlot";

//static final String ADD_DAY_TIME_SLOT = BASE_URL + "addDayTimeSlot";

  static final String ADD_PARTICIPANT = BASE_URL + "addParticipant";
  static final String GET_PARTICIPANT = BASE_URL + "getParticipant";
  static final String UPDATE_PARTICIPANT = BASE_URL + "updateParticipant";
  static final String DELETE_PARTICIPANT = BASE_URL + "deleteParticipant";

  //Booking
  static final String ADD_BOOKING = BASE_URL + "addBooking";
  static final String ADD_BOOKING_SLOT = BASE_URL + "addBookingSlot";
  static final String GET_MY_BOOKINGS = BASE_URL + "getMyBookings";

  //Friend
  static final String ADD_FRIEND = BASE_URL + "addFriend";
  static final String UPDATE_FRIEND = BASE_URL + "updateFriend";
  static final String LIST_FRIENDS = BASE_URL + "listFriends";
  static final String GET_CHAT_PLAYER = BASE_URL + "getChatPlayer";
  static final String GET_FRIEND_REQUEST = BASE_URL + "getFriendRequest";
}
