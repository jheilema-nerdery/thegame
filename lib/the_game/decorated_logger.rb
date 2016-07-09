class TheGame
  class DecoratedLogger
    def initialize(username, debug)
      @username = username

      Rails.logger       = debug ? Logger.new(STDOUT) : Rails.logger
      Rails.logger.level = debug ? 0 : 1
    end

    def debug(message)
      Rails.logger.debug decorate(message)
    end

    def info(message)
      Rails.logger.info decorate(message)
    end

    def warn(message)
      Rails.logger.warn decorate(message)
    end

    def error(message)
      Rails.logger.error decorate(message)
    end

    def fatal(message)
      Rails.logger.fatal decorate(message)
    end

    def unknown(message)
      Rails.logger.unknown decorate(message)
    end

  private

    def decorate(message)
      " #{@username} ".center(16, '-') + " " + message.to_s
    end

  end
end
