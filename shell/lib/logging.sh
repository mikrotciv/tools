# Logging utility module

# Global variables
readonly LOG_LEVELS=("DEBUG" "INFO" "WARNING" "ERROR" "CRITICAL")
readonly LOG_DEBUG=0
readonly LOG_INFO=1
readonly LOG_WARNING=2
readonly LOG_ERROR=3
readonly LOG_CRITICAL=4

# Default log level
LOG_LEVEL=${LOG_INFO}

function logging::get_level() {
  echo ${LOG_LEVEL}
}

function logging::set_level() {
  local readonly new_level=$1; shift
  # TODO: Check level validity?
  LOG_LEVEL=${new_level}
}

function logging::_log(){
  # Parse args
  local readonly log_level=$1; shift
  local readonly message="${@}"

  # Setup log format
  local readonly date_string=$(date +'%Y-%m-%d %H:%M:%S:%s')
  local readonly log_format="${date_string} ${log_level}: ${message}"

  # Log
  echo "${log_format}"
}

function logging::debug() {
  if [[ ${LOG_LEVEL} -le ${LOG_DEBUG} ]]; then
    logging::_log "${LOG_LEVELS[LOG_DEBUG]}" "${@}"
  fi
}

function logging::info() {
  if [[ ${LOG_LEVEL} -le ${LOG_INFO} ]]; then
    logging::_log "${LOG_LEVELS[LOG_INFO]}" "${@}"
  fi
}

function logging::warning() {
  if [[ ${LOG_LEVEL} -le ${LOG_WARNING} ]]; then
    logging::_log "${LOG_LEVELS[LOG_WARNING]}" "${@}"
  fi
}

function logging::error() {
  if [[ ${LOG_LEVEL} -le ${LOG_ERROR} ]]; then
    logging::_log "${LOG_LEVELS[LOG_ERROR]}" "${@}"
  fi
}

function logging::critical() {
  if [[ ${LOG_LEVEL} -le ${LOG_CRITICAL} ]]; then
    logging::_log "${LOG_LEVELS[LOG_CRITICAL]}" "${@}"
  fi
}
