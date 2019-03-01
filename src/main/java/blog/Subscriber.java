package blog;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Subscriber {
	@Parent Key<SubscriberCollection> subscriber;
//	@Id Long id;
	@Id String email;
	@Index String nickname;
	
	private Subscriber() {}
	
	public Subscriber(String email, String nickname) {
			this.email = email;;
	        this.nickname = nickname;
	        this.subscriber = Key.create(SubscriberCollection.class, "subscriber");
	    }
	
	    public String getEmail() {
	        return email;
	    }
	    public String getNickname() {
	        return nickname;
	    }
}
