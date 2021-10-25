class APIResources {
  static final String BASE_URL = "https://lotussoft.in/player/api/";
  static final String IMAGE_URL = "https://lotussoft.in/player/storage/app/";
  static final String AVATAR_IMAGE =
      "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png";

  static final String GET_PLAYER = BASE_URL + "getPlayer";
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
  static final String GET_MY_TOURNAMENT = BASE_URL + "getMyTournament";

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

  static final String ADD_DAY_SLOT = BASE_URL + "addDaySlot";
  static final String GET_DAY_SLOT = BASE_URL + "getDaySlot";
  static final String UPDATE_DAY_SLOT = BASE_URL + "updateDaySlot";
}
