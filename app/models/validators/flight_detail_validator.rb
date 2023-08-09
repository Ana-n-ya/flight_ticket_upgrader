class FlightDetailValidator
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def validate
    validate_ticketing_date_before_travel_date
    validate_mobile_phone_format
    validate_booked_cabin_inclusion
    validate_email_format
    validate_pnr_format

    # always return true to indicate validation has passed
    true
  end

  private

  def add_error_message(error)
    record.error_messages << error
  end

  def validate_ticketing_date_before_travel_date
    if record.ticketing_date && record.travel_date && record.ticketing_date >= record.travel_date
      add_error_message("Ticketing Date is after Travel Date")
    end
  end

  def validate_mobile_phone_format
    unless record.mobile_phone =~ /\A\d{10}\z/
      add_error_message("Invalid Phone Number")
    end
  end

  def validate_pnr_format
    unless record.pnr =~ /\A[a-zA-Z0-9]{6}\z/
      add_error_message("Invalid PNR Number")
    end
  end

  def validate_booked_cabin_inclusion
    unless %w(Economy Premium\ Economy Business First).include?(record.booked_cabin)
      add_error_message("Invalid Booked Cabin")
    end
  end

  def validate_email_format
    unless record.email =~ URI::MailTo::EMAIL_REGEXP
      add_error_message("Invalid Email")
    end
  end
end
