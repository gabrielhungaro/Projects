/*
   All rights reserved.

   TO DO
 */

package com
{
	import com.adobe.serialization.json.JSONFacebook;
	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.FacebookAuthResponse;
	
	import fl.controls.TextArea;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Cheny Schmeling
	 * Redistribution and use in source and binary forms, with or without
	 * modification, are permitted.
	 * */
	
	public class FacebookUserClass extends Sprite
	{
		
		public var APP_ID:String;
		public var APP_SECRET:String;
		public var APP_NAME:String;
		public var APP_ACCESS_TOKEN:String;
		
		private var friendsObject:Object = new Object();
		private var userAlbumsObject:Object = new Object();
		private var userPhotosObject:Object = new Object();
		
		private var arrayAmigosQueUsam:Array = new Array();
		private var arrayAmigosQueUsamPIC:Array = new Array();
		private var arrayAmigosQueUsamNOME:Array = new Array();
		private var arrayAmigosQueUsamSCORE:Array = new Array();
		private var arrayAmigosQueUsamAPP:Array = new Array();
		
		private var userID:String;
		private var userName:String;
		private var userPhotoURL:String;
		private var userFriendsLength:int;
		private var userSex:String;
		private var userCity:String;
		private var userBirthday:String;
		private var userBirthdayDay:String;
		private var userBirthdayMonth:String;
		private var userBirthdayYear:String;
		private var userEmail:String;
		
		private var facebookPermissions:String;
		
		private var isDebug:Boolean;
		
		public var callBackInit:Function;
		public var callBackUserLogin:Function;
		public var callBackUserInfo:Function;
		public var callBackPostToWall:Function;
		public var callBackPostImageToAlbum:Function;
		public var callBackInviteFriends:Function;
		public var callBackLoadFriends:Function;
		public var callBackSaveScore:Function;
		public var callBackLoadFriendsScore:Function;
		public var callBackFriendsWhoUseTheApp:Function;
		public var callBackSendAppRequest:Function;
		public var callBackPostOnFriendWall:Function;
		public var callBackUserAlbums:Function;
		public var callBackUserPhotos:Function;
		
		public var outputTxt:TextArea;
		public var gameScore:int;
		
		public function FacebookUserClass():void
		{
		
		}
		
		public function activateCallBackFunctions(_callBackInit:Function = null, _callBackUserLogin:Function = null, _callBackUserInfo:Function = null, _callBackPostToWall:Function = null, _callBackPostImageToAlbum:Function = null, _callBackInviteFriends:Function = null, _callBackLoadFriends:Function = null, _callBackSaveScore:Function = null, _callBackLoadFriendsScore:Function = null, _callBackFriendsWhoUseTheApp:Function = null, _callBackSendAppRequest:Function = null, _callBackPostOnFriendWall:Function = null, _callBackUserAlbums:Function = null, _callBackUserPhotos:Function = null):void
		{
			this.callBackInit = _callBackInit;
			this.callBackUserLogin = _callBackUserLogin;
			this.callBackUserInfo = _callBackUserInfo;
			this.callBackPostToWall = _callBackPostToWall;
			this.callBackPostImageToAlbum = _callBackPostImageToAlbum;
			this.callBackInviteFriends = _callBackInviteFriends;
			this.callBackLoadFriends = _callBackLoadFriends;
			this.callBackSaveScore = _callBackSaveScore;
			this.callBackLoadFriendsScore = _callBackLoadFriendsScore;
			this.callBackFriendsWhoUseTheApp = _callBackFriendsWhoUseTheApp;
			this.callBackSendAppRequest = _callBackSendAppRequest;
			this.callBackPostOnFriendWall = _callBackPostOnFriendWall;
			this.callBackUserAlbums = _callBackUserAlbums;
			this.callBackUserPhotos = _callBackUserPhotos;
		}
		
		public function init(appIDString:String, appSecretString:String, debugMode:Boolean = false, output:TextArea = null):void
		{
			this.isDebug = debugMode;
			this.outputTxt = output;
			
			//outputTxt.appendText("\n [ FacebookUserClassInit ] - ");
			
			var options:Object = new Object;
			options.frictionlessRequests = true;
			
			Facebook.init(APP_ID, onCallBackInit, options);
		}
		
		/**
		 * Asks for Facebook permissions to access the user data info.
		 * @param permissions = "publish_actions, publish_stream, user_photos, user_birthday, etc...".
		 * */
		public function setPermissions(permissions:String):void
		{
			facebookPermissions = permissions;
		}
		
		protected function onCallBackInit(result:Object, fail:Object = null):void
		{
			//outputTxt.appendText("--------------------------------------------------------");
			//outputTxt.appendText("\n######  [onCallBackInit]  ######");
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					outputTxt.appendText("--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackInit]  ######")
					outputTxt.appendText("\n[SUCCESS]: Connected with Facebook API!");
				}
				
				var response:FacebookAuthResponse = result as FacebookAuthResponse;
				if (response != null)
				{
					if (isDebug)
					{
						outputTxt.appendText("\n[UID]: " + response.uid + "\n[ACCES TOKEN]: " + response.accessToken);
					}
					APP_ACCESS_TOKEN = response.accessToken;
				}
				
				methodExists = this["callBackInit"] != null;
				if (methodExists)
				{
					callBackInit("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackInit]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				methodExists = this["callBackInit"] != null;
				if (methodExists)
				{
					callBackInit("Fail", fail);
				}
			}
		}
		
		public function loadLogin():void
		{
			var params:Object = new Object;
			params.scope = facebookPermissions;
			Facebook.login(onCallBackLogin, params);
		}
		
		protected function onCallBackLogin(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLogin]  ######")
					outputTxt.appendText("\n[SUCCESS]: User connected with Facebook API.");
				}
				
				var response:FacebookAuthResponse = result as FacebookAuthResponse;
				if (response != null)
				{
					if (isDebug)
					{
						outputTxt.appendText("\n[UID]: " + response.uid + "\n[ACCES TOKEN]: " + response.accessToken);
					}
					APP_ACCESS_TOKEN = response.accessToken;
				}
				
				methodExists = this["callBackUserLogin"] != null;
				if (methodExists)
				{
					callBackUserLogin("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLogin]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackUserLogin"] != null;
				if (methodExists)
				{
					callBackUserLogin("Fail", fail);
				}
				
			}
		}
		
		public function loadUserInfo():void
		{
			var params:Object = new Object;
			params.access_token = APP_ACCESS_TOKEN;
			Facebook.api("/me", onCallBackUserInfoLoaded, params);
		}
		
		protected function onCallBackUserInfoLoaded(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackUserInfoLoaded]  ######")
					outputTxt.appendText("\n[SUCCESS]: User information has been loaded.");
					outputTxt.appendText(JSONFacebook.encode(result));
				}
				userID = result.id;
				userName = result.name;
				userPhotoURL = Facebook.getImageUrl(Facebook.getAuthResponse().uid);
				userSex = result.gender;
				if (result.email) {
					userEmail = result.email;
				}else {
					userEmail = "null";
				}
				
				if (result.hometown)
				{
					userCity = result.hometown.name;
					var arrayCharsA:Array = new Array("Á", "Ã", "Â", "á", "ã", "â");
					var arrayCharsE:Array = new Array("É", "Ê", "é", "ê");
					var arrayCharsI:Array = new Array("Í", "Î", "í", "î");
					var arrayCharsO:Array = new Array("Ó", "Õ", "Ô", "ó", "õ", "ô");
					var arrayCharsU:Array = new Array("Ú", "Û", "ú", "û");
					
					var newCityName:Array = new Array();
					
					for (var i:int = 0; i < userCity.length; i++) 
					{
						newCityName[i] = userCity.charAt(i);
						
						for (var j:int = 0; j < arrayCharsA.length; j++) 
						{
							if (userCity.charAt(i) == arrayCharsA[j]) newCityName[i] = "a";
						}
						
						for (var k:int = 0; k < arrayCharsE.length; k++) 
						{
							if (userCity.charAt(i) == arrayCharsE[k]) newCityName[i] = "e";
						}
						
						for (var l:int = 0; l < arrayCharsI.length; l++) 
						{
							if (userCity.charAt(i) == arrayCharsE[i]) newCityName[i] = "i";
						}
						
						for (var m:int = 0; m < arrayCharsO.length; m++) 
						{
							if (userCity.charAt(i) == arrayCharsO[m]) newCityName[i] = "o";
						}
						
						for (var n:int = 0; n < arrayCharsU.length; n++) 
						{
							if (userCity.charAt(i) == arrayCharsU[n]) newCityName[i] = "u";
						}
					}
					
					var newCityNameNow:String = new String();
					
					for (var o:int = 0; o < newCityName.length; o++) 
					{
						newCityNameNow += newCityName[o];
					}
					
					userCity = newCityNameNow;
				}
				else
				{
					userCity = "null";
				}
				if (result.birthday)
				{
					userBirthday = result.birthday;
					
					var split:Array = userBirthday.split("/")
					
					userBirthdayMonth = String(split[0]);
					userBirthdayDay = String(split[1]);
					userBirthdayYear = String(split[2]);
				}
				else
				{
					userBirthday = "null";
				}
				
				methodExists = this["callBackUserInfo"] != null;
				if (methodExists)
				{
					callBackUserInfo("Success", result);
				}
				
				//outputTxt.appendText("\n\n" + userID + " " + userName + " " + userSex + " " + userCity + " " + userBirthday + " " + userEmail + " " + userBirthdayDay + " " + userBirthdayMonth + " " + userBirthdayYear);
				//outputTxt.appendText("\n\n" + userBirthdayYear + "-" + userBirthdayMonth + "-" + userBirthdayDay)
				
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackUserInfoLoaded]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				methodExists = this["callBackUserInfo"] != null;
				if (methodExists)
				{
					callBackUserInfo("Fail", fail);
				}
			}
		}
		
		/**
		 * Post a feed on the user facebook wall with the current information:
		 * @param _name = "Eu fiz o teste profissional Guia do Estudante";
		 * @param _picture = "http://abril.cheny.com.br/guiadoestudante/aplicativoFacebook/logo.png"
		 * @param _caption = String("Sou: " + "<b>" + "resultado1" + ", " + "resultado2" + ", " + "resultado3" + " e " + "resultado4" + "</b>") + "<center></center> ";
		 * @param _description = String("Minhas profissões podem ser: <center></center>" + "<b>" + "xml_XML.*[1].*[resultadoFinal - 1].*[0].@tipo" + ", " + "xml_XML.*[1].*[resultadoFinal - 1].*[1].@tipo" + ", " + "xml_XML.*[1].*[resultadoFinal - 1].*[2].@tipo" + ", " + "xml_XML.*[1].*[resultadoFinal - 1].*[3].@tipo" + "...</b> <center></center> <center></center> Para saber mais sobre o seu futuro profissional acesse o site do Guia do Estudante");
		 * @param _link = String("http://apps.facebook.com/" + APP_ID);
		 * @example = <b> for bold, <center></center> for paragraph,
		 * */
		public function loadPostToWall(_name:String, _picture:String, _caption:String, _description:String, _link:String):void
		{
			var params:Object = new Object;
			params.name = _name;
			params.picture = _picture;
			params.caption = _caption;
			params.description = _description;
			params.link = _link
			Facebook.ui("feed", params, onCallBackPostWall);
		}
		
		protected function onCallBackPostWall(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result == null)
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackPostWall]  ######")
					outputTxt.appendText("\n*WARNING*: User has closed post to wall iframe window.");
				}
				return
			}
			
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackPostWall]  ######")
					outputTxt.appendText("\n[SUCCESS]: Message has been posted successfully!");
				}
				
				methodExists = this["callBackPostToWall"] != null;
				if (methodExists)
				{
					callBackPostToWall("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackPostWall]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackPostToWall"] != null;
				if (methodExists)
				{
					callBackPostToWall("Fail", fail);
				}
			}
		}
		
		/**
		 * Post a image to the application default album on the user facebook account.
		 * @params message = Eu fiz o teste profissional Guia do Estudante:\n http://apps.facebook.com/" + APP_NAME + "\n\n" + "Sou: " + "resultado1" + ", " + "resultado2" + ", " + "resultado3" + " e " + "resultado4" + "\n\n" + "Minhas profissões podem ser: \n" + "xml_XML.*[1].*[resultadoFinal - 1].*[0].@tipo" + ", " + "xml_XML.*[1].*[resultadoFinal - 1].*[1].@tipo" + ", " + "xml_XML.*[1].*[resultadoFinal - 1].*[2].@tipo" + ", " + "xml_XML.*[1].*[resultadoFinal - 1].*[3].@tipo" + "... \n\n" + "Saiba mais sobre o seu perfil profissional, acesse: " + String("");
		 * @params image = telaResultado
		 * @usage = "\n" for paragraph, "hyperlink" works normally
		 * */
		public function loadPostImageToAlbum(message:String, image:MovieClip = null):void
		{
			var bitmapData:BitmapData = new BitmapData(image.width, image.height);
			bitmapData.draw(image);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			
			var params:Object = new Object;
			params.access_token = APP_ACCESS_TOKEN;
			params.message = message;
			params.image = bitmap;
			params.fileName = ".jpg";
			Facebook.api("/me/photos", onCallBackPostImageToAlbum, params, "POST");
		}
		
		private function onCallBackPostImageToAlbum(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackPostImageToAlbum]  ######")
					outputTxt.appendText("\n[SUCCESS]: Image has been posted on album successfully!");
				}
				
				methodExists = this["callBackPostImageToAlbum"] != null;
				if (methodExists)
				{
					callBackPostImageToAlbum("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackPostImageToAlbum]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackPostImageToAlbum"] != null;
				if (methodExists)
				{
					callBackPostImageToAlbum("Fail", fail);
				}
			}
		}
		
		public function loadInviteFriends(title:String, message:String):void
		{
			var data:Object = new Object();
			data.message = message;
			data.title = title;
			// filtering for non app users only
			data.filters = ['app_non_users'];
			//You can use these two options for diasplaying friends invitation window 'iframe' 'popup'
			Facebook.ui("apprequests", data, onCallBackInviteFriends);
		}
		
		protected function onCallBackInviteFriends(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result == null)
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackInviteFriends]  ######")
					outputTxt.appendText("\n*WARNING*: User has closed Friend Invite iframe window.");
				}
				return
			}
			
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackInviteFriends]  ######")
					outputTxt.appendText("\n[SUCCESS]: Friends invited successfully!");
				}
				
				methodExists = this["callBackInviteFriends"] != null;
				if (methodExists)
				{
					callBackInviteFriends("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackInviteFriends]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				methodExists = this["callBackInviteFriends"] != null;
				if (methodExists)
				{
					callBackInviteFriends("Fail", fail);
				}
			}
		
		/*			var invitedUsers:Array  = new Array();
		   invitedUsers = result.request_ids as Array;
		   trace("You Have Invited ", invitedUsers.length, "friends");
		   //Simple if else if you want user to invite certain amount of friends
		   if(invitedUsers.length > 1){
		   trace('GREAT, USER IS GENERATING TRAFFIC');
		   }else{
		   trace('No Good, User invited only one friend.');
		 }*/
		}
		
		public function loadFriends():void
		{
			Facebook.api("/me/friends", onCallBackLoadFriends);
		}
		
		protected function onCallBackLoadFriends(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				var jsonString:String = JSONFacebook.encode(result);
				var jsonObj:Object = JSONFacebook.decode(jsonString);
				
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadFriends]  ######")
					outputTxt.appendText("\n[SUCCESS]: Friends loaded successfully!");
					outputTxt.appendText("\n[TOTAL FRIENDS]: " + jsonObj.length);
				}
				
				friendsObject = jsonObj;
				userFriendsLength = jsonObj.length;
				
				arrayAmigosQueUsamNOME = [];
				arrayAmigosQueUsamPIC = [];
				arrayAmigosQueUsamAPP = [];
				
				for (var i:int = 0; i < arrayAmigosQueUsam.length; i++)
				{
					for (var j:int = 0; j < jsonObj.length; j++)
					{
						if (String(arrayAmigosQueUsam[i]) == String(jsonObj[j].id))
						{
							//outputTxt.appendText("\nNOME: " + String(jsonObj[j].name));
							//outputTxt.appendText("\nFOTO URL: " + String(Facebook.getImageUrl(jsonObj[j].id)));
							arrayAmigosQueUsamNOME.push(String(jsonObj[j].name));
							arrayAmigosQueUsamPIC.push(String(Facebook.getImageUrl(jsonObj[j].id)));
						}
					}
				}
				
				for (var k:int = 0; k < arrayAmigosQueUsamNOME.length; k++)
				{
					for (var l:int = 0; l < arrayAmigosQueUsamSCORE.length; l++)
					{
						if (String(arrayAmigosQueUsamNOME[k]) == String(arrayAmigosQueUsamSCORE[l].user.name))
						{
							
							if (isDebug)
							{
								outputTxt.appendText("\n[USER]: " + String(arrayAmigosQueUsamNOME[k]));
							}
							
							var objeto:Object = new Object();
							objeto.nome = new Object();
							objeto.url = new Object();
							objeto.resultado = new Object();
							
							objeto.nome = arrayAmigosQueUsamNOME[k];
							objeto.setURL = arrayAmigosQueUsamPIC[k];
							objeto.resultado = arrayAmigosQueUsamSCORE[l].score;
							
							arrayAmigosQueUsamAPP.push(objeto);
						}
					}
				}
				
				methodExists = this["callBackLoadFriends"] != null;
				if (methodExists)
				{
					callBackLoadFriends("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadFriends]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackLoadFriends"] != null;
				if (methodExists)
				{
					callBackLoadFriends("Fail", fail);
				}
			}
		}
		
		public function loadSaveScore():void
		{
			var data:Object = new Object();
			data.score = gameScore;
			data.client_id = APP_ID;
			data.client_secret = APP_SECRET;
			Facebook.api("/me/scores/", onCallBackSaveScore, data, "POST");
		}
		
		protected function onCallBackSaveScore(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackSaveScore]  ######")
					outputTxt.appendText("\n[SUCCESS]: Game score saved successfully!");
				}
				
				methodExists = this["callBackSaveScore"] != null;
				if (methodExists)
				{
					callBackSaveScore("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackSaveScore]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackSaveScore"] != null;
				if (methodExists)
				{
					callBackSaveScore("Fail", fail);
				}
			}
		}
		
		public function loadFriendsScore():void
		{
			Facebook.api(APP_ID + "/scores/", onCallBackLoadFriendsScore);
		}
		
		protected function onCallBackLoadFriendsScore(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadFriendsScore]  ######")
					outputTxt.appendText("\n[SUCCESS]: Friends game scores has been received successfully!");
				}
				
				var jsonString:String = JSONFacebook.encode(result);
				var jsonObj:Object = JSONFacebook.decode(jsonString);
				
				arrayAmigosQueUsamSCORE = [];
				
				if (isDebug)
				{
					outputTxt.appendText("\n[--RANKING-- : " + String(jsonObj[0].application.namespace) + "]");
				}
				
				APP_NAME = String(jsonObj[0].application.namespace);
				for (var i:int = 0; i < jsonObj.length; i++)
				{
					if (isDebug)
					{
						outputTxt.appendText("\n[USER]: " + String(jsonObj[i].user.name));
						outputTxt.appendText("\n[SCORE]: " + String(jsonObj[i].score));
					}
					arrayAmigosQueUsamSCORE.push(jsonObj[i]);
				}
				
				methodExists = this["callBackLoadFriendsScore"] != null;
				if (methodExists)
				{
					callBackLoadFriendsScore("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadFriendsScore]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackLoadFriendsScore"] != null;
				if (methodExists)
				{
					callBackLoadFriendsScore("Fail", fail);
				}
			}
		}
		
		//
		public function loadFriendsWhoUseTheApp(e:MouseEvent = null):void
		{
			Facebook.api("me/friends", onCallBackFriendsWhoUseTheApp, {acces_token: APP_ACCESS_TOKEN, fields: "installed"});
		}
		
		private function onCallBackFriendsWhoUseTheApp(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackFriendsWhoUseTheApp]  ######")
					outputTxt.appendText("\n[SUCCESS]: Friends who use the app have been loaded successfully!");
				}
				
				var jsonString:String = JSONFacebook.encode(result);
				var jsonObj:Object = JSONFacebook.decode(jsonString);
				
				arrayAmigosQueUsam = [];
				
				for (var i:int = 0; i < jsonObj.length; i++)
				{
					if (jsonObj[i].installed)
					{
						if (isDebug)
						{
							outputTxt.appendText("\n[FRIEND ID]: " + String(jsonObj[i].id));
								//outputTxt.appendText("\nUSES APP? " + String(jsonObj[i].installed));
						}
						arrayAmigosQueUsam.push(jsonObj[i].id);
					}
				}
				
				if (isDebug)
				{
					outputTxt.appendText("\n[FRIENDS LENGTH]: " + String(arrayAmigosQueUsam.length));
				}
				
				methodExists = this["callBackFriendsWhoUseTheApp"] != null;
				if (methodExists)
				{
					callBackFriendsWhoUseTheApp("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackFriendsWhoUseTheApp]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackFriendsWhoUseTheApp"] != null;
				if (methodExists)
				{
					callBackFriendsWhoUseTheApp("Fail", fail);
				}
			}
		}
		
		//
		public function loadSendAppRequest(title:String, message:String, userID:String):void
		{
			var data:Object = new Object();
			data.title = title;
			data.message = message;
			data.to = userID;
			Facebook.ui("apprequests", data, onCallBackSendAppRequests);
		}
		
		protected function onCallBackSendAppRequests(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadAppRequests]  ######")
					outputTxt.appendText("\n[SUCCESS]: App request to friend has been sent successfully!");
				}
				
				methodExists = this["callBackSendAppRequest"] != null;
				if (methodExists)
				{
					callBackSendAppRequest("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadAppRequests]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				methodExists = this["callBackSendAppRequest"] != null;
				if (methodExists)
				{
					callBackSendAppRequest("Fail", fail);
				}
			}
		}
		
		//
		public function loadPostOnFriendWall(friendUserID:String):void
		{
			var data:Object = new Object();
			data.message = "My Great Message";
			data.picture = "http://www.cheny.com.br/sandboxMode_Facebook/logo.jpg";
			data.link = "http://apps.facebook.com/sandboxmode";
			data.name = "test name";
			data.caption = "test caption";
			data.description = "test long description";
			Facebook.api("/" + friendUserID + "/feed", onCallBackPostOnFriendWall, data, "POST");
		}
		
		private function onCallBackPostOnFriendWall(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackPostOnFriendWall]  ######")
					outputTxt.appendText("\n[SUCCESS]: Post on friends wall has been sent successfully!");
				}
				
				methodExists = this["callBackPostOnFriendWall"] != null;
				if (methodExists)
				{
					callBackPostOnFriendWall("Success", result);
				}
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackPostOnFriendWall]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				methodExists = this["callBackPostOnFriendWall"] != null;
				if (methodExists)
				{
					callBackPostOnFriendWall("Fail", fail);
				}
			}
		}
		
		//
		public function loadUserAlbums():void
		{
			/*
			   var data:Object = new Object();
			   data.fields = "picture";
			   data.type = "uploaded";
			   data.limit = 9999;
			   Facebook.api("/" + getUserID() + "/photos/", onCallBackLoadUserAlbumPhotos, data);
			 */
			
			var data:Object = new Object();
			data.limit = 0;
			Facebook.api("/" + getUserID() + "/albums/", onCallBackLoadUserAlbum, data);
		}
		
		private function onCallBackLoadUserAlbum(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadUserAlbum]  ######")
					outputTxt.appendText("\n[SUCCESS]: Albums loaded successfully");
						//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
				}
				
				var jsonString:String = JSONFacebook.encode(result);
				var jsonObj:Object = JSONFacebook.decode(jsonString);
				userAlbumsObject = jsonObj;
				
				methodExists = this["callBackUserAlbums"] != null;
				if (methodExists)
				{
					callBackUserAlbums("Success", result);
				}
				
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadUserAlbum]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackUserAlbums"] != null;
				if (methodExists)
				{
					callBackUserAlbums("Fail", fail);
				}
				
			}
		}
		
		//
		public function loadUserPhotosByAlbumID(albumID:String):void
		{
			var data:Object = new Object();
			data.fields = "picture";
			data.limit = 0;
			Facebook.api("/" + albumID + "/photos/", onCallBackLoadUserPhotosByAlbum, data);
		}
		
		private function onCallBackLoadUserPhotosByAlbum(result:Object, fail:Object = null):void
		{
			var methodExists:Boolean;
			if (result)
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadUserPhotosByAlbum]  ######")
					outputTxt.appendText("\n[SUCCESS]: Photos loaded successfully");
						//outputTxt.appendText("\n\nRESULT:\n" + JSONFacebook.encode(result));
				}
				
				var jsonString:String = JSONFacebook.encode(result);
				var jsonObj:Object = JSONFacebook.decode(jsonString);
				userPhotosObject = jsonObj;
				
				methodExists = this["callBackUserPhotos"] != null;
				if (methodExists)
				{
					callBackUserPhotos("Success", result);
				}
				
			}
			else
			{
				if (isDebug)
				{
					outputTxt.appendText("\n--------------------------------------------------------")
					outputTxt.appendText("\n######  [onCallBackLoadUserPhotosByAlbum]  ######")
					outputTxt.appendText("\n<ERROR>: " + JSONFacebook.encode(fail));
				}
				
				methodExists = this["callBackUserPhotos"] != null;
				if (methodExists)
				{
					callBackUserPhotos("Fail", fail);
				}
				
			}
		}
		
		/*
		 * 	#############
		 * 	### GETTERS ###
		 *	#############
		 */
		
		/**
		 * ## Returns the complete user id as a String.
		 * */
		public function getUserID():String
		{
			return userID;
		}
		
		/**
		 * ## Returns the complete user name as a String.
		 * */
		public function getUserName():String
		{
			return userName;
		}
		
		/**
		 * ## Returns the user photo URL as a String.
		 * */
		public function getUserPhoto():String
		{
			return userPhotoURL;
		}
		
		/**
		 * ## Returns the user friends length.
		 * */
		public function getUserFriendsLength():uint
		{
			return userFriendsLength;
		}
		
		/**
		 * ## Returns the user sex gender as a String.
		 * */
		public function getUserSex():String
		{
			return userSex;
		}
		
		/**
		 * ## Returns the user city as a String.
		 * */
		public function getUserCity():String
		{
			return userCity;
		}
		
		/**
		 * ## Returns the user city as a String.
		 * */
		public function getUserBirthday():String
		{
			return userBirthday;
		}
		
		/**
		 * ## Returns the user birthday segmented as a String.
		 * */
		public function getUserBirthdaySegmented():Array
		{
			var arrayBirthday:Array = new Array(userBirthdayDay, userBirthdayMonth, userBirthdayYear);
			return arrayBirthday;
		}
		
		/**
		 * ## Returns the user Email as a String.
		 * */
		public function getUserEmail():String
		{
			return userEmail;
		}
		
		/**
		 * ## Returns the user friends as an array of objects
		 * @return Object = Return an "Object[i].id", an "Object[i].name" and an "Object[i].photo".
		 * */
		public function getUserFriends():Object
		{
			for (var i:int = 0; i < getUserFriendsLength(); i++)
			{
				friendsObject[i].photo = new Object();
				friendsObject[i].photo = getPhotoURL(friendsObject[i].id);
			}
			return friendsObject;
		}
		
		/**
		 * ## Returns the user friends as an array of objects
		 * @param total = The total friends with photo you want the app returns.
		 * @return Object = Return an "Object[i].id", an "Object[i].name" and an "Object[i].photo".
		 * */
		public function getUserFriendsByTotal(total:int):Object
		{
			var newFriendsObject:Object = new Object();
			for (var i:int = 0; i < total; i++)
			{
				newFriendsObject[i] = new Object();
				newFriendsObject[i].id = new Object();
				newFriendsObject[i].name = new Object();
				newFriendsObject[i].photo = new Object();
				
				newFriendsObject[i].id = friendsObject[i].id;
				newFriendsObject[i].name = friendsObject[i].name;
				newFriendsObject[i].photo = getPhotoURL(friendsObject[i].id);
			}
			return newFriendsObject;
		}
		
		/**
		 * ## Returns the user friends as an array of objects in alphabetically order
		 * @return Array = Return an "Object[i].id", an "Object[i].name" and an "Object[i].photo" in alphabetically order.
		 * */
		public function getUserFriendsInAlphabeticallyOrder():Array
		{
			var newFriendsArray:Array = new Array();
			
			for (var i:int = 0; i < getUserFriendsLength(); i++)
			{
				newFriendsArray.push({id: String(friendsObject[i].id), name: friendsObject[i].name, photo: getPhotoURL(friendsObject[i].id)});
			}
			
			newFriendsArray = newFriendsArray.sortOn("name");
			return newFriendsArray;
		}
		
		/**
		 * ## Returns the user friends as an array of objects in alphabetically order
		 * @param total = The total friends with photo you want the app returns.
		 * @return Array = Return an "Object[i].id", an "Object[i].name" and an "Object[i].photo" in alphabetically order.
		 * */
		public function getUserFriendsInAlphabeticallyOrderByTotal(total:uint):Array
		{
			var newFriendsArray:Array = new Array();
			
			for (var i:int = 0; i < total; i++)
			{
				newFriendsArray.push({id: String(friendsObject[i].id), name: friendsObject[i].name, photo: getPhotoURL(friendsObject[i].id)});
			}
			
			newFriendsArray = newFriendsArray.sortOn("name");
			return newFriendsArray;
		}
		
		/**
		 * ## Returns the user friend info
		 * @return Object = Return an "Object[i].id", an "Object[i].name" and an "Object[i].photo" from a friend.
		 * */
		public function getUserFriendInfoByID(id:String):Object
		{
			var userFriendInfo:Object;
			for (var i:int = 0; i < getUserFriendsLength(); i++)
			{
				if (friendsObject[i].id == id)
				{
					friendsObject[i].photo = new Object();
					friendsObject[i].photo = getPhotoURL(friendsObject[i].id);
					userFriendInfo = friendsObject[i] as Object;
				}
			}
			
			return userFriendInfo;
		}
		
		/**
		 * ## Returns the photo URL as a String by passing an id;
		 * @param id = User's id from Facebook
		 * */
		public function getPhotoURL(id:String):String
		{
			return Facebook.getImageUrl(id);
		}
		
		//
		public function getUserAlbums():Array
		{
			return userAlbumsObject as Array;
		}
		
		//
		public function getUserPhotos():Array
		{
			return userPhotosObject as Array;
		}
	
	}
}