
def index
  loop do   
    # Find all Run Once jobs, and run them   
    RunOncePeriodicJob.find_all_need_to_run.each do |job|     
      job.run!   
    end    
    # Find all Run on Interval jobs, and run them     
    RunIntervalPeriodicJob.find_all_need_to_run.each do |job|     
      job.run!   
    end      
    # Cleans up periodic jobs, removes all RunOncePeriodicJobs over one   
    # day old.   
    RunOncePeriodicJob.cleanup      
    sleep(SLEEP_TIME) 
  end
end