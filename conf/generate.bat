java -cp .;commons-logging-1.0.4.jar;log4j-1.2.8.jar;hibernate-tools.jar;hibernate2.jar; net.sf.hibernate.tool.class2hbm.MapGenerator --output=Calendar.hbm org.infoglue.calendar.entities.Calendar 

java -cp .;commons-logging-1.0.4.jar;log4j-1.2.8.jar;hibernate-tools.jar;hibernate2.jar; net.sf.hibernate.tool.class2hbm.MapGenerator --output=Event.hbm org.infoglue.calendar.entities.Event

java -cp .;commons-logging-1.0.4.jar;log4j-1.2.8.jar;hibernate-tools.jar;hibernate2.jar; net.sf.hibernate.tool.class2hbm.MapGenerator --output=Location.hbm org.infoglue.calendar.entities.Location

java -cp .;commons-logging-1.0.4.jar;log4j-1.2.8.jar;hibernate-tools.jar;hibernate2.jar; net.sf.hibernate.tool.class2hbm.MapGenerator --output=Category.hbm org.infoglue.calendar.entities.Category

java -cp .;commons-logging-1.0.4.jar;log4j-1.2.8.jar;hibernate-tools.jar;hibernate2.jar; net.sf.hibernate.tool.class2hbm.MapGenerator --output=Participant.hbm org.infoglue.calendar.entities.Participant

java -cp .;commons-logging-1.0.4.jar;log4j-1.2.8.jar;hibernate-tools.jar;hibernate2.jar; net.sf.hibernate.tool.class2hbm.MapGenerator --output=Resource.hbm org.infoglue.calendar.entities.Resource