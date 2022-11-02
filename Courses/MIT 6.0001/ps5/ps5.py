# 6.0001/6.00 Problem Set 5 - RSS Feed Filter
# Name:
# Collaborators:
# Time:

import feedparser
import string
import time
import threading
from project_util import translate_html
from mtTkinter import *
from datetime import datetime
import pytz


#-----------------------------------------------------------------------

#======================
# Code for retrieving and parsing
# Google and Yahoo News feeds
# Do not change this code
#======================

def process(url):
    """
    Fetches news items from the rss url and parses them.
    Returns a list of NewsStory-s.
    """
    feed = feedparser.parse(url)
    entries = feed.entries
    ret = []
    for entry in entries:
        guid = entry.guid
        title = translate_html(entry.title)
        link = entry.link
        description = translate_html(entry.description)
        pubdate = translate_html(entry.published)

        try:
            pubdate = datetime.strptime(pubdate, "%a, %d %b %Y %H:%M:%S %Z")
            pubdate.replace(tzinfo=pytz.timezone("GMT"))
          #  pubdate = pubdate.astimezone(pytz.timezone('EST'))
          #  pubdate.replace(tzinfo=None)
        except ValueError:
            pubdate = datetime.strptime(pubdate, "%a, %d %b %Y %H:%M:%S %z")

        newsStory = NewsStory(guid, title, description, link, pubdate)
        ret.append(newsStory)
    return ret

#======================
# Data structure design
#======================

# Problem 1
class NewsStory(object):
    """ The NewsStory class stores information about a single a news story. """
    def __init__(self, guid, title, description, link, pubdate):
        """
        Creates a new NewsStory Object.
        
        Attributes:
            guid (int) i.e globally unique identifier
            title (string)
            description (string)
            link (string)
            pubdate (datetime)
        
        Methods:
            get_guid(self)
                returns self.guid
            
            get_title(self)
                returns self.title
            
            get_description(self)
                returns self.description
            
            get_link(self)
                returns self.link
            
            get_pubdate(self)
                returns self.pubdate
        """
        self.guid = guid
        self.title = title
        self.description = description
        self.link = link
        self.pubdate = pubdate
    
    def get_guid(self):
        """
        Used to safely access self.guid outside of the class
        
        returns self.guid
        """
        return self.guid

    def get_title(self):
        """
        Used to safely access self.title outside of the class
        
        returns self.title
        """
        return self.title

    def get_description(self):
        """
        Used to safely access self.description outside of the class
        
        returns self.description
        """
        return self.description

    def get_link(self):
        """
        Used to safely access self.link outside of the class
        
        returns self.link
        """
        return self.link

    def get_pubdate(self):
        """
        Used to safely access self.pubdate outside of the class
        
        returns self.pubdate
        """
        return self.pubdate


#======================
# Triggers
#======================

class Trigger(object):
    def evaluate(self, story):
        """
        Returns True if an alert should be generated
        for the given news item, or False otherwise.
        """
        # DO NOT CHANGE THIS!
        raise NotImplementedError

# PHRASE TRIGGERS

# Problem 2
class PhraseTrigger(Trigger):
    """ The PhraseTrigger abstract class is a subclass of the Trigger class. """
    def __init__(self, phrase):
        """
        Creates a new PhraseTrigger object.

        Attributes:
            self.phrase (string, lowercase)
        
        Methods:
            is_phrase_in(self, text)
                returns True/False
        """
        self.phrase = phrase.lower()

    def is_phrase_in(self, text):
        """
        Evaluates whether self.phrase is in the given text or not.
        Not case sensitive. Ignores punctuation.
        Phrase must be found in the same order of words as self.phrase.

        return True/False
        """
        text_copy = [' ' if char in string.punctuation \
                    else char.lower() for char in text]
        word_list = ''.join(text_copy).split()

        phrase_list = self.phrase.split()
        first = phrase_list[0]

        start = -1
        for first in word_list:
            start = word_list.index(first, start + 1)
            if phrase_list == word_list[start:start+len(phrase_list)]:
                return True
        return False

# Problem 3
class TitleTrigger(PhraseTrigger):
    """ The TitleTrigger class triggers if a given phrase is in the title of a news story. """
    def __init__(self, phrase):
        """
        Creates a new TitleTrigger object.
        
        Attributes:
            self.phrase (string, lowercase)
        
        Methods:
            evaluate(self, story)
                returns True/False
        """
        super().__init__(phrase)
    
    def __repr__(self):
        """ returns a string representation of the object. """
        return f"TitleTrigger('{self.phrase}')"

    def evaluate(self, story):
        """
        Evaluates whether self.phrase is in the given story's title.
        
        returns True/False
        """
        return self.is_phrase_in(story.get_title())

# Problem 4
class DescriptionTrigger(PhraseTrigger):
    """ The DescriptionTrigger class triggers if a given phrase is in the description of a news story. """
    def __init__(self, phrase):
        """
        Creates a new DescriptionTrigger object.
        
        Attributes:
            self.phrase (string, lowercase)
        
        Methods:
            evaluate(self, story)
                returns True/False
        """
        super().__init__(phrase)
    
    def __repr__(self):
        """ returns a string representation of the object. """
        return f"DescriptionTrigger('{self.phrase}')"

    def evaluate(self, story):
        """
        Evaluates whether self.phrase is in the given story's description.
        
        returns True/False
        """
        return self.is_phrase_in(story.get_description())

# TIME TRIGGERS

# Problem 5
class TimeTrigger(Trigger):
    """ The TimeTrigger abstract class is a subclass of the Trigger class. """
    def __init__(self, time_string):
        """
        Creates a new TimeTrigger object.
        
        Input: Time has to be in EST and in the format of "%d %b %Y %H:%M:%S".
        Convert time from string to a datetime before saving it as an attribute.

        Attributes:
            self.time (datetime)
        """
        self.time = datetime.strptime(time_string, "%d %b %Y %H:%M:%S").replace(tzinfo=pytz.timezone("EST"))

# Problem 6
class BeforeTrigger(TimeTrigger):
    """ The BeforeTrigger class triggers if a a story was published before a given date and time. """
    def __init__(self, time_string):
        """
        Creates a new BeforeTrigger object.
        
        Attributes:
            self.time (datetime)
        
        Methods:
            evaluate(self, story)
                returns True/False
        """
        super().__init__(time_string)
    
    def __repr__(self):
        """ returns a string representation of the object. """
        return f"BeforeTrigger('{self.time}')"

    def evaluate(self, story):
        """
        Evaluates whether the given story was published strictly before self.time.
        
        returns True/False
        """
        return self.time > story.get_pubdate().replace(tzinfo=pytz.timezone("EST"))

class AfterTrigger(TimeTrigger):
    """ The AfterTrigger class triggers if a a story was published after a given date and time. """
    def __init__(self, time_string):
        """
        Creates a new AfterTrigger object.
        
        Attributes:
            self.time (datetime)
        
        Methods:
            evaluate(self, story)
                returns True/False
        """
        super().__init__(time_string)
    
    def __repr__(self):
        """ returns a string representation of the object. """
        return f"AfterTrigger('{self.time}')"

    def evaluate(self, story):
        """
        Evaluates whether the given story was published strictly after self.time.
        
        returns True/False
        """
        return self.time < story.get_pubdate().replace(tzinfo=pytz.timezone("EST"))

# COMPOSITE TRIGGERS

# Problem 7
class NotTrigger(Trigger):
    """ The NotTrigger class is used to evaluate the negation of a Trigger on a news story. """
    def __init__(self, trig):
        """
        Creates a new NotTrigger object.
        
        Attributes:
            self.trig (Trigger)
        
        Methods:
            self.evaluate(self, story (NewsStory))
                returns True/False    
        """
        self.trig = trig
    
    def __repr__(self):
        """ returns a string representation of the object. """
        return f"NotTrigger({self.trig})"

    def evaluate(self, story):
        """
        Evaluates the negation of whether the trigger fires on the given news story.
        
        returns True/False
        """
        return not self.trig.evaluate(story)


# Problem 8
class AndTrigger(Trigger):
    """ The AndTrigger class is used to evaluate if both Triggers fire on a news story. """
    def __init__(self, trig1, trig2):
        """
        Creates a new AndTrigger object.
        
        Attributes:
            self.trig1 (Trigger)
            self.trig2 (Trigger)
        
        Methods:
            self.evaluate(self, story (NewsStory))
                returns True/False    
        """
        self.trig1 = trig1
        self.trig2 = trig2
    
    def __repr__(self):
        """ returns a string representation of the object. """
        return f"AndTrigger({self.trig1}, {self.trig2})"

    def evaluate(self, story):
        """
        Evaluates whether both of the triggers fire on the given news story.
        
        returns True/False
        """
        return self.trig1.evaluate(story) and self.trig2.evaluate(story)

# Problem 9
class OrTrigger(Trigger):
    """ The OrTrigger class is used to evaluate if one or both Triggers fire on a news story. """
    def __init__(self, trig1, trig2):
        """
        Creates a new OrTrigger object.
        
        Attributes:
            self.trig1 (Trigger)
            self.trig2 (Trigger)
        
        Methods:
            self.evaluate(self, story (NewsStory))
                returns True/False    
        """
        self.trig1 = trig1
        self.trig2 = trig2
    
    def __repr__(self):
        """ returns a string representation of the object. """
        return f"OrTrigger({self.trig1}, {self.trig2})"

    def evaluate(self, story):
        """
        Evaluates whether one or both of the triggers fire on the given news story.
        
        returns True/False
        """
        return self.trig1.evaluate(story) or self.trig2.evaluate(story)


#======================
# Filtering
#======================

# Problem 10
def filter_stories(stories, triggerlist):
    """
    Takes in a list of NewsStory instances.

    Returns: a list of only the stories for which a trigger in triggerlist fires.
    """
    # TODO: Problem 10
    # This is a placeholder
    # (we're just returning all the stories, with no filtering)
    return stories



#======================
# User-Specified Triggers
#======================
# Problem 11
def read_trigger_config(filename):
    """
    filename: the name of a trigger configuration file

    Returns: a list of trigger objects specified by the trigger configuration
        file.
    """
    # We give you the code to read in the file and eliminate blank lines and
    # comments. You don't need to know how it works for now!
    trigger_file = open(filename, 'r')
    lines = []
    for line in trigger_file:
        line = line.rstrip()
        if not (len(line) == 0 or line.startswith('//')):
            lines.append(line)

    # TODO: Problem 11
    # line is the list of lines that you need to parse and for which you need
    # to build triggers

    print(lines) # for now, print it so you see what it contains!



SLEEPTIME = 120 #seconds -- how often we poll

def main_thread(master):
    # A sample trigger list - you might need to change the phrases to correspond
    # to what is currently in the news
    try:
        t1 = TitleTrigger("election")
        t2 = DescriptionTrigger("Trump")
        t3 = DescriptionTrigger("Clinton")
        t4 = AndTrigger(t2, t3)
        triggerlist = [t1, t4]

        # Problem 11
        # TODO: After implementing read_trigger_config, uncomment this line 
        # triggerlist = read_trigger_config('triggers.txt')
        
        # HELPER CODE - you don't need to understand this!
        # Draws the popup window that displays the filtered stories
        # Retrieves and filters the stories from the RSS feeds
        frame = Frame(master)
        frame.pack(side=BOTTOM)
        scrollbar = Scrollbar(master)
        scrollbar.pack(side=RIGHT,fill=Y)

        t = "Google & Yahoo Top News"
        title = StringVar()
        title.set(t)
        ttl = Label(master, textvariable=title, font=("Helvetica", 18))
        ttl.pack(side=TOP)
        cont = Text(master, font=("Helvetica",14), yscrollcommand=scrollbar.set)
        cont.pack(side=BOTTOM)
        cont.tag_config("title", justify='center')
        button = Button(frame, text="Exit", command=root.destroy)
        button.pack(side=BOTTOM)
        guidShown = []
        def get_cont(newstory):
            if newstory.get_guid() not in guidShown:
                cont.insert(END, newstory.get_title()+"\n", "title")
                cont.insert(END, "\n---------------------------------------------------------------\n", "title")
                cont.insert(END, newstory.get_description())
                cont.insert(END, "\n*********************************************************************\n", "title")
                guidShown.append(newstory.get_guid())

        while True:

            print("Polling . . .", end=' ')
            # Get stories from Google's Top Stories RSS news feed
            stories = process("http://news.google.com/news?output=rss")

            # Get stories from Yahoo's Top Stories RSS news feed
            stories.extend(process("http://news.yahoo.com/rss/topstories"))

            stories = filter_stories(stories, triggerlist)

            list(map(get_cont, stories))
            scrollbar.config(command=cont.yview)


            print("Sleeping...")
            time.sleep(SLEEPTIME)

    except Exception as e:
        print(e)


if __name__ == '__main__':
    root = Tk()
    root.title("Some RSS parser")
    t = threading.Thread(target=main_thread, args=(root,))
    t.start()
    root.mainloop()

