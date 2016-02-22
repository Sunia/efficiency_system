# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160222174729) do

  create_table "operating_conditions", force: :cascade do |t|
    t.float    "sea_report_id",              limit: 24
    t.float    "visual_fwd",                 limit: 24
    t.float    "visual_mid_ship",            limit: 24
    t.float    "visual_aft",                 limit: 24
    t.float    "visual_trim",                limit: 24
    t.float    "load_dep_fwd",               limit: 24
    t.float    "load_dep_mid_ship",          limit: 24
    t.float    "load_dep_aft",               limit: 24
    t.float    "load_dep_trim",              limit: 24
    t.float    "load_daily_fwd",             limit: 24
    t.float    "load_daily_mid_ship",        limit: 24
    t.float    "load_daily_aft",             limit: 24
    t.float    "load_daily_trim",            limit: 24
    t.float    "metacentric_height",         limit: 24
    t.float    "ballast_water_quantity",     limit: 24
    t.float    "loading_dep_sf",             limit: 24
    t.float    "loading_dep_bm",             limit: 24
    t.float    "loading_daily_sf",           limit: 24
    t.float    "loading_daily_bm",           limit: 24
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "speed_log_status",           limit: 255
    t.date     "speed_log_date"
    t.string   "vessel_fitted_with_torsion", limit: 255
    t.string   "torsion_meter_status",       limit: 255
    t.date     "torsion_meter_date"
    t.float    "roll_angle",                 limit: 24
    t.float    "dock_water_density",         limit: 24
  end

  create_table "passage_plans", force: :cascade do |t|
    t.integer  "lat_degree",    limit: 4
    t.float    "lat_min",       limit: 24
    t.string   "lat_dir",       limit: 255
    t.integer  "long_degree",   limit: 4
    t.float    "long_min",      limit: 24
    t.string   "long_dir",      limit: 255
    t.string   "status",        limit: 255, default: "new"
    t.integer  "sea_report_id", limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "waypoint_no",   limit: 4
    t.string   "rl_gc",         limit: 255
    t.boolean  "start_point",               default: false
    t.boolean  "end_point",                 default: false
    t.integer  "sea_port_id",   limit: 4
  end

  create_table "power_fuels", force: :cascade do |t|
    t.integer  "sea_report_id",                            limit: 4
    t.integer  "me_power",                                 limit: 4
    t.float    "hours",                                    limit: 24
    t.float    "me_rpm",                                   limit: 24
    t.string   "tc_cut_out",                               limit: 255
    t.integer  "me_load_mcr",                              limit: 4
    t.float    "me_total_average",                         limit: 24
    t.float    "me_sfoc",                                  limit: 24
    t.float    "properties_lcv_hshfo",                     limit: 24
    t.float    "properties_lcv_lshfo",                     limit: 24
    t.float    "properties_lcv_hsmdo",                     limit: 24
    t.float    "properties_lcv_lsmdo",                     limit: 24
    t.float    "properties_sulphur_hshfo",                 limit: 24
    t.float    "properties_sulphur_lshfo",                 limit: 24
    t.float    "properties_sulphur_hsmdo",                 limit: 24
    t.float    "properties_sulphur_lsmdo",                 limit: 24
    t.float    "oil_consumers_me_hshfo",                   limit: 24
    t.float    "oil_consumers_me_lshfo",                   limit: 24
    t.float    "oil_consumers_me_hsmdo",                   limit: 24
    t.float    "oil_consumers_me_lsmdo",                   limit: 24
    t.float    "oil_consumers_aux_hshfo",                  limit: 24
    t.float    "oil_consumers_aux_lshfo",                  limit: 24
    t.float    "oil_consumers_aux_hsmdo",                  limit: 24
    t.float    "oil_consumers_aux_lsmdo",                  limit: 24
    t.float    "oil_consumers_boiler_hshfo",               limit: 24
    t.float    "oil_consumers_boiler_lshfo",               limit: 24
    t.float    "oil_consumers_boiler_hsmdo",               limit: 24
    t.float    "oil_consumers_boiler_lsmdo",               limit: 24
    t.float    "oil_consumers_boiler_sludge",              limit: 24
    t.float    "oil_consumers_total_hshfo",                limit: 24
    t.float    "oil_consumers_total_lshfo",                limit: 24
    t.float    "oil_consumers_total_hsmdo",                limit: 24
    t.float    "oil_consumers_total_lsmdo",                limit: 24
    t.float    "oil_consumers_total_sludge",               limit: 24
    t.integer  "generators_aux1_power",                    limit: 4
    t.float    "generators_aux1_hours",                    limit: 24
    t.integer  "generators_aux2_power",                    limit: 4
    t.float    "generators_aux2_hours",                    limit: 24
    t.integer  "generators_aux3_power",                    limit: 4
    t.float    "generators_aux3_hours",                    limit: 24
    t.integer  "generators_aux4_power",                    limit: 4
    t.float    "generators_aux4_hours",                    limit: 24
    t.float    "generators_total_power",                   limit: 24
    t.integer  "electrical_consumers_reefers_power",       limit: 4
    t.integer  "electrical_consumers_reefers_number",      limit: 4
    t.integer  "electrical_consumers_reefer_cargo_power",  limit: 4
    t.integer  "electrical_consumers_reefer_cargo_number", limit: 4
    t.integer  "electrical_consumers_aux_power",           limit: 4
    t.integer  "electrical_consumers_total_power",         limit: 4
    t.float    "electrical_consumers_ae_sfoc",             limit: 24
    t.integer  "electrical_consumers_basic_load",          limit: 4
    t.integer  "electrical_consumers_reference",           limit: 4
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "sea_ports", force: :cascade do |t|
    t.string   "starting_port_name", limit: 255
    t.string   "reached_port_name",  limit: 255
    t.boolean  "is_reached",                     default: false
    t.string   "description",        limit: 255
    t.string   "vessel_name",        limit: 255
    t.integer  "vessel_imo_no",      limit: 4
    t.integer  "vessel_id",          limit: 4
    t.string   "captain_name",       limit: 255
    t.string   "chief_engineer",     limit: 255
    t.string   "zone_time",          limit: 255
    t.string   "smt_time",           limit: 255
    t.integer  "total_reports",      limit: 4,   default: 0
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "sea_reports", force: :cascade do |t|
    t.boolean  "is_closed",                            default: false
    t.string   "closed_time_in_smt",       limit: 255
    t.datetime "closed_time_in_utc"
    t.string   "opened_time_in_smt",       limit: 255
    t.integer  "report_number",            limit: 4
    t.integer  "integer",                  limit: 4
    t.integer  "sea_port_id",              limit: 4
    t.string   "zone_time",                limit: 255
    t.string   "report_period_in_hrs",     limit: 255, default: "0"
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.string   "description",              limit: 255, default: "Zone time remains the same."
    t.boolean  "is_last_report",                       default: false
    t.datetime "update_passage_plan_date"
    t.float    "avg_me_power",             limit: 24
    t.float    "avg_me_rpm",               limit: 24
    t.float    "avg_speed_log_knots",      limit: 24
    t.float    "avg_speed_observed_knots", limit: 24
    t.float    "total_trip_counter_log",   limit: 24
    t.float    "total_trip_counter_gps",   limit: 24
    t.float    "total_distance_rem_eosp",  limit: 24
    t.float    "total_time_rem_eosp",      limit: 24
    t.string   "weather_observation_smt",  limit: 255
    t.datetime "weather_observation_utc"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weather_distances", force: :cascade do |t|
    t.integer  "sea_report_id",         limit: 4
    t.datetime "observation_utc"
    t.string   "observation_smt",       limit: 255
    t.text     "position",              limit: 65535
    t.integer  "me_power",              limit: 4
    t.float    "me_rpm",                limit: 24
    t.string   "reliable_observation",  limit: 255
    t.float    "trip_counter_log",      limit: 24
    t.float    "trip_counter_gps",      limit: 24
    t.float    "distance_rem_eosp",     limit: 24
    t.float    "time_rem_eosp",         limit: 24
    t.float    "speed_knots",           limit: 24
    t.float    "speed_observed_knots",  limit: 24
    t.float    "true_wind_force",       limit: 24
    t.integer  "true_wind_dir",         limit: 4
    t.float    "true_wind_speed_knots", limit: 24
    t.float    "wave_height",           limit: 24
    t.integer  "true_swell_direction",  limit: 4
    t.float    "true_swell_height",     limit: 24
    t.integer  "water_depth",           limit: 4
    t.integer  "couse_over_ground",     limit: 4
    t.integer  "gyro_course",           limit: 4
    t.integer  "compass_course",        limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "avg_rudder_angle",      limit: 24
  end

end
