/*
	swfOP is an open source library for manipulation and examination of
	Macromedia Flash ActionScript bytecode.
	Copyright (C) 2004 Florian Kr�sch
	see Licence.cs for LGPL full text 
	
	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.
	
	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.
	
	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

using System;
using System.IO;
using SwfOp.Data.Tags;

namespace SwfOp.Data.Tags {
	
	
	/// <summary>
	/// DefineBits tag for Jpeg images in swf
	/// </summary>
	public class DefineBitsJpeg3Tag : SwfOp.Data.Tags.BaseTag {
		
		private byte[] jpegData;
		private byte[] alphaData;
		private ushort characterId;
		
		/// <summary>
		/// constructor
		/// </summary>
		public DefineBitsJpeg3Tag(ushort id,byte[] image,byte[] alpha) {
			characterId = id;
			jpegData = image;	
			alphaData = alpha;
		}
		
		/// <summary>
		/// JPEG Data
		/// </summary>
		public byte[] JpegData {
			get {
				return jpegData;
			}
			set {
				jpegData = value;
			}
		}
		
		/// <summary>
		/// alpha Data
		/// </summary>
		public byte[] AlphaData {
			get {
				return alphaData;
			}
			set {
				alphaData = value;
			}
		}
		
		/// <summary>
		/// see <see cref="SwfOp.Data.Tags.BaseTag">base class</see>
		/// </summary>
		public override void UpdateData(byte version) {
				
			MemoryStream m = new MemoryStream();
			BinaryWriter w = new BinaryWriter(m);
			
			RecordHeader rh = new RecordHeader(TagCode, 6 + jpegData.Length + alphaData.Length ,true);
			
			rh.WriteTo(w);
			w.Write(characterId);
			w.Write(Convert.ToUInt32(jpegData.Length));
			w.Write(jpegData);
			w.Write(alphaData);
			
			// write to data array
			_data = m.ToArray();			
		}
	}
}
